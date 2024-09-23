extends Node

var dungeon_level = 0

var current_dungeon = []
var current_dungeon_type = ""
var size = 0

const ROOM_SPACING = 2560
var north_block_off
var south_block_off
var east_block_off
var west_block_off

var display_exit_prompt = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	north_block_off = load("res://LevelParts/Dungeon/Rooms/Medieval/medieval_north_block_off.tscn")
	south_block_off = load("res://LevelParts/Dungeon/Rooms/Medieval/medieval_south_block_off.tscn")
	east_block_off = load("res://LevelParts/Dungeon/Rooms/Medieval/medieval_east_block_off.tscn")
	west_block_off = load("res://LevelParts/Dungeon/Rooms/Medieval/medieval_west_block_off.tscn")

# start_node needs to be a String passed to this system.
func generate_dungeon(start_node, max_distance):
	generate_grid(max_distance)
	#place_room(start_node, Vector2(max_distance, max_distance))
	var start = load(start_node)
	var temp_start = start.instantiate()
	current_dungeon_type = temp_start.dungeon_type
	temp_start.queue_free()
	place_room(start, Vector2(max_distance, max_distance))
	fix_rooms(current_dungeon_type)
	space_out_rooms()
	print (current_dungeon)
	Player.position = Vector2(max_distance * ROOM_SPACING, max_distance * ROOM_SPACING)
	dungeon_level += 1
	#current_dungeon[max_distance][max_distemp_starttance] = new_dungeon
	#new_dungeon.grid_location = Vector2(max_distance, max_distance)
	#put_rooms(new_dungeon)
	
func generate_grid(max_distance):
	size = max_distance * 2
	for row in size:
		current_dungeon.push_back([])
		for column in size:
			current_dungeon[row].push_back(0)

func put_rooms(room_reference):
	if (not room_reference.north_room_closed and not room_reference.grid_location.x - 1 < 0
		and current_dungeon[room_reference.grid_location.x - 1][room_reference.grid_location.y] is int):
		var north_room = pick_room("north", current_dungeon_type)
		place_room(north_room, Vector2(room_reference.grid_location.x - 1, room_reference.grid_location.y))
	if (not room_reference.south_room_closed and not room_reference.grid_location.x + 1 >= size
		and current_dungeon[room_reference.grid_location.x + 1][room_reference.grid_location.y] is int):
		var south_room = pick_room("south", current_dungeon_type)
		place_room(south_room, Vector2(room_reference.grid_location.x + 1, room_reference.grid_location.y))
	if (not room_reference.east_room_closed and not room_reference.grid_location.y + 1 >= size
		and current_dungeon[room_reference.grid_location.x][room_reference.grid_location.y + 1] is int):
		var east_room = pick_room("east", current_dungeon_type)
		place_room(east_room, Vector2(room_reference.grid_location.x, room_reference.grid_location.y + 1))
	if (not room_reference.west_room_closed and not room_reference.grid_location.y - 1 < 0
		and current_dungeon[room_reference.grid_location.x][room_reference.grid_location.y - 1] is int):
		var west_room = pick_room("west", current_dungeon_type)
		place_room(west_room, Vector2(room_reference.grid_location.x, room_reference.grid_location.y - 1))


func pick_room(direction, dungeon_type):
	var choice = GlobalRandomNumberGenerator.rng.randi_range(1, 4)
	var list
	match dungeon_type:
		"medieval":
			match direction:
				"north": 
					list = RoomSetup.medieval_north
				"south":
					list = RoomSetup.medieval_south
				"east":
					list = RoomSetup.medieval_east
				"west":
					list = RoomSetup.medieval_west
		_:
			pass
	return list[choice][GlobalRandomNumberGenerator.rng.randi_range(0, list[choice].size() - 1)]

func place_room(room_to_place, position):
	var new_room = room_to_place.instantiate()
	#print(current_dungeon[position.y])
	current_dungeon[position.x][position.y] = new_room
	new_room.grid_location = Vector2(position.x, position.y)
	add_child(new_room)
	put_rooms(new_room)

func fix_rooms(dungeon_type):
	match dungeon_type:
		"medieval":
			for row in size:
				for column in size:
					var selected = current_dungeon[row][column]
					if selected is not int:
						if (not selected.north_room_closed and ((row - 1 < 0)
							or (current_dungeon[row - 1][column] is int) 
							or (current_dungeon[row - 1][column].south_room_closed))):
							close_off(selected, "north")
						if (not selected.south_room_closed and ((row + 1 >= size)
							or (current_dungeon[row + 1][column] is int)
							or (current_dungeon[row + 1][column].north_room_closed))):
							close_off(selected, "south")
						if (not selected.east_room_closed and ((column + 1 >= size)
							or (current_dungeon[row][column + 1] is int) 
							or (current_dungeon[row][column + 1].west_room_closed))):
							close_off(selected, "east")
						if (not selected.west_room_closed and ((column - 1 < 0)
							or (current_dungeon[row][column - 1] is int) 
							or (current_dungeon[row][column - 1].east_room_closed))):
							close_off(selected, "west")
		_:
			pass

func close_off(room_reference, direction):
	# place block off
	var block_off
	match direction:
		"north": 
			block_off = north_block_off
			#room_reference.north_room_closed = true
		"south":
			block_off = south_block_off
			#room_reference.south_room_closed = true
		"east":
			block_off = east_block_off
			#room_reference.east_room_closed = true
		_:
			block_off = west_block_off
			#room_reference.west_room_closed = true
	var instanced_block_off = block_off.instantiate()
	room_reference.add_child(instanced_block_off)
			

func space_out_rooms():
	for row in size:
		for column in size:
			var selected_room = current_dungeon[row][column]
			if selected_room is not int:
				selected_room.position = Vector2(column * ROOM_SPACING, row * ROOM_SPACING)

func clear_dungeon():
	for row in size:
		for column in size:
			if not current_dungeon[row][column] == 0:
				current_dungeon[row][column].queue_free()
	current_dungeon.clear()

					#for room_openings in list:
						#for option in list[room_openings]:
							#var instanced_option = option.instantiate()
							#var new_room_location = room_reference.grid_location + Vector(0, -1)
							#if new_room_location.current_dungeon[new_room_location.x][new_room_location.y] :
