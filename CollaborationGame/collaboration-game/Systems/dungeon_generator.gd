extends Node

var dungeon_level = 0

var current_dungeon = []
var current_dungeon_type = ""
var size = 0
var current_room
var dungeon_loaded = false

const ROOM_SPACING = 2624

# these are the medieval block offs. they should probably eventually go into room
# setup
var north_block_off
var south_block_off
var east_block_off
var west_block_off

# mob spawner node to place inside of rooms
var mob_spawner
var activator_node

var fog_node

var display_exit_prompt = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	north_block_off = load("res://LevelParts/Dungeon/Rooms/Medieval/medieval_north_block_off.tscn")
	south_block_off = load("res://LevelParts/Dungeon/Rooms/Medieval/medieval_south_block_off.tscn")
	east_block_off = load("res://LevelParts/Dungeon/Rooms/Medieval/medieval_east_block_off.tscn")
	west_block_off = load("res://LevelParts/Dungeon/Rooms/Medieval/medieval_west_block_off.tscn")
	mob_spawner = load("res://Systems/mob_spawner.tscn")
	activator_node = load("res://LevelParts/activation_area.tscn")
	fog_node = load("res://LevelParts/Dungeon/fog.tscn")

# start_node needs to be a String passed to this system.
func generate_dungeon(start_node, max_distance):
	LootGenerator.add_loot_list(FileReader.open_and_read_file
	("res://LevelParts/Dungeon/Rooms/Medieval/LootLists/BaseMedievalLootList.txt"))
	generate_grid(max_distance)
	var start = load(start_node)
	var temp_start = start.instantiate()
	current_dungeon_type = temp_start.dungeon_type
	temp_start.queue_free()
	place_room(start, Vector2(max_distance, max_distance))
	place_exit()
	fix_rooms(current_dungeon_type)
	decorate_rooms()
	place_doors()
	space_out_rooms()
	print (current_dungeon)
	PlayerHandler.current_player.position = Vector2(max_distance * ROOM_SPACING, max_distance * ROOM_SPACING)
	current_room = Vector2(max_distance, max_distance)
	dungeon_level += 1
	dungeon_loaded = true
	
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

func place_exit():
	match current_dungeon_type:
		"medieval":
			var direction_choice = GlobalRandomNumberGenerator.rng.randi_range(1, 4)
			var exit_room_choice
			var exits = RoomSetup.medieval_exits
			match direction_choice:
				# start from the NE
				1:
					exit_room_choice = find_exit_space(0, size - 1, 1, -1, exits)
				# start from the NW
				2:
					exit_room_choice = find_exit_space(0, 0, 1, 1, exits)
				# start from the SW
				3:
					exit_room_choice = find_exit_space(size - 1, 0, -1, 1, exits)
				# start from the SE
				4:
					exit_room_choice = find_exit_space(size - 1, size - 1, -1, -1, exits)
			var exit = exit_room_choice[0]
			var exit_position = exit_room_choice[1]
			var exit_instance = exit.instantiate()
			current_dungeon[exit_position.x][exit_position.y] = exit_instance
			add_child(exit_instance)
		_:
			pass
			
func find_exit_space(starting_x, starting_y, x_increment, y_increment, exits):
	var exit_space = 0
	var ending_x = size - 1 if starting_x == 0 else 0
	var ending_y = size - 1 if starting_y == 0 else 0
	for row in range(starting_x, ending_x, x_increment):
		for column in range(starting_y, ending_y, y_increment):
			if current_dungeon[row][column] is int:
				var north_room = 0 if row - 1 < 0 else current_dungeon[row - 1][column]
				var south_room = 0 if row + 1 >= size else current_dungeon[row + 1][column]
				var east_room = 0 if column + 1 >= size else current_dungeon[row][column + 1]
				var west_room = 0 if column - 1 < 0 else current_dungeon[row][column - 1]
				if north_room is not int:
					exit_space = exits["S"][GlobalRandomNumberGenerator.rng.randi_range(0, exits["S"].size() - 1)]
					if north_room.south_room_closed:
						replace_room("south", north_room)
					return [exit_space, Vector2(row, column)]
				if south_room is not int:
					exit_space = exits["N"][GlobalRandomNumberGenerator.rng.randi_range(0, exits["N"].size() - 1)]
					if south_room.north_room_closed:
						replace_room("north", south_room)
					return  [exit_space, Vector2(row, column)]
				if east_room is not int:
					exit_space = exits["W"][GlobalRandomNumberGenerator.rng.randi_range(0, exits["W"].size() - 1)]
					if east_room.west_room_closed:
						replace_room("west", east_room)
					return  [exit_space, Vector2(row, column)]
				if west_room is not int:
					exit_space = exits["E"][GlobalRandomNumberGenerator.rng.randi_range(0, exits["E"].size() - 1)]
					if west_room.east_room_closed:
						replace_room("east", west_room)
					return  [exit_space, Vector2(row, column)]
	if exit_space is int:
		var north_room = 0 if starting_x - 1 < 0 else current_dungeon[starting_x - 1][starting_y]
		var south_room = 0 if starting_x + 1 >= size else current_dungeon[starting_x + 1][starting_y]
		var east_room = 0 if starting_y + 1 >= size else current_dungeon[starting_x][starting_y + 1]
		var west_room = 0 if starting_y - 1 < 0 else current_dungeon[starting_x][starting_y - 1]
		if north_room is not int:
			exit_space = exits["S"][GlobalRandomNumberGenerator.rng.randi_range(0, exits["S"].size() - 1)]
			current_dungeon[starting_x][starting_y].queue_free()
			if north_room.south_room_closed:
				replace_room("south", north_room)
			return [exit_space, Vector2(starting_x, starting_y)]
		if south_room is not int:
			exit_space = exits["N"][GlobalRandomNumberGenerator.rng.randi_range(0, exits["N"].size() - 1)]
			current_dungeon[starting_x][starting_y].queue_free()
			if south_room.north_room_closed:
				replace_room("north", south_room)
			return  [exit_space, Vector2(starting_x, starting_y)]
		if east_room is not int:
			exit_space = exits["W"][GlobalRandomNumberGenerator.rng.randi_range(0, exits["W"].size() - 1)]
			current_dungeon[starting_x][starting_y].queue_free()
			if east_room.west_room_closed:
				replace_room("west", east_room)
			return  [exit_space, Vector2(starting_x, starting_y)]
		if west_room is not int:
			exit_space = exits["E"][GlobalRandomNumberGenerator.rng.randi_range(0, exits["E"].size() - 1)]
			current_dungeon[starting_x][starting_y].queue_free()
			if west_room.east_room_closed:
				replace_room("east", west_room)
			return  [exit_space, Vector2(starting_x, starting_y)]
	return exit_space

func replace_room(new_opening, room_to_replace):
	var north_open = not room_to_replace.north_room_closed
	var south_open = not room_to_replace.south_room_closed
	var east_open = not room_to_replace.east_room_closed
	var west_open = not room_to_replace.west_room_closed
	var openings = (
		1 if north_open else 0 + 
		1 if south_open else 0 +
		1 if east_open else 0 +
		1 if west_open else 0
	)
	var replacement_room
	var potential_replacements = []
	var real_potential_replacements = []
	if openings == 3:
		replacement_room = (RoomSetup.medieval_north[4][GlobalRandomNumberGenerator.rng.
		randi_range(0, RoomSetup.medieval_north[4].size() - 1)])
	else:
		match new_opening:
			"north":
				if openings == 2:
					if south_open:
						potential_replacements.append_array(RoomSetup.medieval_north[3])
						potential_replacements.append_array(RoomSetup.medieval_north[4])
					elif east_open:
						potential_replacements.append_array(RoomSetup.medieval_west[3])
						potential_replacements.append_array(RoomSetup.medieval_west[4])
					elif west_open:
						potential_replacements.append_array(RoomSetup.medieval_east[3])
						potential_replacements.append_array(RoomSetup.medieval_east[4])
				elif openings == 1:
					if south_open:
						potential_replacements.append_array(RoomSetup.medieval_north[2])
						potential_replacements.append_array(RoomSetup.medieval_north[3])
						potential_replacements.append_array(RoomSetup.medieval_north[4])
					elif east_open:
						potential_replacements.append_array(RoomSetup.medieval_west[2])
						potential_replacements.append_array(RoomSetup.medieval_west[3])
						potential_replacements.append_array(RoomSetup.medieval_west[4])
					elif west_open:
						potential_replacements.append_array(RoomSetup.medieval_east[2])
						potential_replacements.append_array(RoomSetup.medieval_east[3])
						potential_replacements.append_array(RoomSetup.medieval_east[4])
				for open_room in potential_replacements:
					var temp_room = open_room.instantiate()
					if not temp_room.north_room_closed:
						real_potential_replacements.push_back(open_room)
					temp_room.queue_free()
			"south":
				if openings == 2:
					if north_open:
						potential_replacements.append_array(RoomSetup.medieval_south[3])
						potential_replacements.append_array(RoomSetup.medieval_south[4])
					elif east_open:
						potential_replacements.append_array(RoomSetup.medieval_west[3])
						potential_replacements.append_array(RoomSetup.medieval_west[4])
					elif west_open:
						potential_replacements.append_array(RoomSetup.medieval_east[3])
						potential_replacements.append_array(RoomSetup.medieval_east[4])
				elif openings == 1:
					if north_open:
						potential_replacements.append_array(RoomSetup.medieval_south[2])
						potential_replacements.append_array(RoomSetup.medieval_south[3])
						potential_replacements.append_array(RoomSetup.medieval_south[4])
					elif east_open:
						potential_replacements.append_array(RoomSetup.medieval_west[2])
						potential_replacements.append_array(RoomSetup.medieval_west[3])
						potential_replacements.append_array(RoomSetup.medieval_west[4])
					elif west_open:
						potential_replacements.append_array(RoomSetup.medieval_east[2])
						potential_replacements.append_array(RoomSetup.medieval_east[3])
						potential_replacements.append_array(RoomSetup.medieval_east[4])
				for open_room in potential_replacements:
					var temp_room = open_room.instantiate()
					if not temp_room.south_room_closed:
						real_potential_replacements.push_back(open_room)
					temp_room.queue_free()
			"east":
				if openings == 2:
					if north_open:
						potential_replacements.append_array(RoomSetup.medieval_south[3])
						potential_replacements.append_array(RoomSetup.medieval_south[4])
					elif south_open:
						potential_replacements.append_array(RoomSetup.medieval_north[3])
						potential_replacements.append_array(RoomSetup.medieval_north[4])
					elif west_open:
						potential_replacements.append_array(RoomSetup.medieval_east[3])
						potential_replacements.append_array(RoomSetup.medieval_east[4])
				elif openings == 1:
					if north_open:
						potential_replacements.append_array(RoomSetup.medieval_south[2])
						potential_replacements.append_array(RoomSetup.medieval_south[3])
						potential_replacements.append_array(RoomSetup.medieval_south[4])
					elif south_open:
						potential_replacements.append_array(RoomSetup.medieval_north[2])
						potential_replacements.append_array(RoomSetup.medieval_north[3])
						potential_replacements.append_array(RoomSetup.medieval_north[4])
					elif west_open:
						potential_replacements.append_array(RoomSetup.medieval_east[2])
						potential_replacements.append_array(RoomSetup.medieval_east[3])
						potential_replacements.append_array(RoomSetup.medieval_east[4])
				for open_room in potential_replacements:
					var temp_room = open_room.instantiate()
					if not temp_room.east_room_closed:
						real_potential_replacements.push_back(open_room)
					temp_room.queue_free()
			"west":
				if openings == 2:
					if north_open:
						potential_replacements.append_array(RoomSetup.medieval_south[3])
						potential_replacements.append_array(RoomSetup.medieval_south[4])
					elif south_open:
						potential_replacements.append_array(RoomSetup.medieval_north[3])
						potential_replacements.append_array(RoomSetup.medieval_north[4])
					elif east_open:
						potential_replacements.append_array(RoomSetup.medieval_west[3])
						potential_replacements.append_array(RoomSetup.medieval_west[4])
				elif openings == 1:
					if north_open:
						potential_replacements.append_array(RoomSetup.medieval_south[2])
						potential_replacements.append_array(RoomSetup.medieval_south[3])
						potential_replacements.append_array(RoomSetup.medieval_south[4])
					elif south_open:
						potential_replacements.append_array(RoomSetup.medieval_north[2])
						potential_replacements.append_array(RoomSetup.medieval_north[3])
						potential_replacements.append_array(RoomSetup.medieval_north[4])
					elif east_open:
						potential_replacements.append_array(RoomSetup.medieval_west[2])
						potential_replacements.append_array(RoomSetup.medieval_west[3])
						potential_replacements.append_array(RoomSetup.medieval_west[4])
				for open_room in potential_replacements:
					var temp_room = open_room.instantiate()
					if not temp_room.west_room_closed:
						real_potential_replacements.push_back(open_room)
					temp_room.queue_free()
		replacement_room = real_potential_replacements[GlobalRandomNumberGenerator.rng.randi_range(0, real_potential_replacements.size() - 1)]
	var room_location = room_to_replace.grid_location
	remove_child(room_to_replace)
	room_to_replace.queue_free()
	var new_room = replacement_room.instantiate()
	current_dungeon[room_location.x][room_location.y] = new_room
	add_child(new_room)

func decorate_rooms():
	for row in size:
		for column in size:
			var selected_room = current_dungeon[row][column]
			if not selected_room is int and not selected_room is starting_room:
				var fog_instance = fog_node.instantiate()
				selected_room.add_child(fog_instance)
				var attribute = select_attribute()
				if not attribute is String:
					selected_room.add_child(attribute)
					selected_room.room_aspect = attribute
					var activator = activator_node.instantiate()
					selected_room.add_child(activator)

# gives a room a thing to spawn between nothing, mobs, or treasure
func select_attribute():
	var choice = GlobalRandomNumberGenerator.rng.randi_range(1, 3)
	match choice:
		1:
			return "nothing"
		2:
			#var spawner = mob_spawner.instantiate()
			#spawner.num_mobs_to_spawn = GlobalRandomNumberGenerator.rng.randi_range(10, 20)
			return "spawner"
		3: 
			var loot = LootGenerator.generate_loot()
			return "nothing"

func place_doors():
	for row in size:
		for column in size:
			var selected_room = current_dungeon[row][column]
			if not selected_room is int and not selected_room is starting_room:
				var doors = RoomSetup.medieval_doors.instantiate()
				doors.process_mode = Node.PROCESS_MODE_DISABLED
				doors.visible = false
				selected_room.add_child(doors)
				selected_room.doors_node = doors

func space_out_rooms():
	for row in size:
		for column in size:
			var selected_room = current_dungeon[row][column]
			if selected_room is not int:
				selected_room.position = Vector2(column * ROOM_SPACING, row * ROOM_SPACING)

func clear_dungeon():
	for row in size:
		for column in size:
			if not current_dungeon[row][column] is int:
				current_dungeon[row][column].queue_free()
	current_dungeon.clear()
