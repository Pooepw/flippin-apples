extends Node2D

class_name room

@export var north_room_closed: bool
@export var south_room_closed: bool
@export var east_room_closed: bool
@export var west_room_closed: bool

var grid_location = Vector2(0, 0)

var room_aspect
var doors_node

func close_off(side):
	side = true

func rooms_closed():
	return (north_room_closed and south_room_closed 
	and east_room_closed and west_room_closed)

func activate_room_aspect():
	if room_aspect is mob_spawner_class:
		room_aspect.start_spawning()
		activate_doors()
		
func activate_doors():
	doors_node.process_mode = Node.PROCESS_MODE_ALWAYS
	doors_node.visible = true
	#if north_room_closed:
		#var north_door = doors_node.get_node("MedievalNorthDoor")
		#north_door.process_mode = Node.PROCESS_MODE_DISABLED
		#north_door.visible = false
	#if south_room_closed:
		#var south_door = doors_node.get_node("MedievalSouthDoor")
		#south_door.process_mode = Node.PROCESS_MODE_DISABLED
		#south_door.visible = false
	#if east_room_closed:
		#var east_door = doors_node.get_node("MedievalEastDoor")
		#east_door.process_mode = Node.PROCESS_MODE_DISABLED
		#east_door.visible = false
	#if west_room_closed:
		#var west_door = doors_node.get_node("MedievalWestDoor")
		#west_door.process_mode = Node.PROCESS_MODE_DISABLED
		#west_door.visible = false

#func put_room():
	#if not north_room_closed:
		#var north_room = pick_room("north")
		#DungeonGenerator.current_dungeon
	#if not south_room_closed:
		#var south_room = pick_room("south")
	#if not east_room_closed:
		#var east_room = pick_room("east")
	#if not west_room_closed:
		#var west_room = pick_room("west")
	
#func pick_room(direction):
	#var choice = GlobalRandomNumberGenerator.randi_range(1, 4)
	#var list
	#match direction:
		#"north": 
			#list = possible_north
		#"south":
			#list = possible_south
		#"east":
			#list = possible_east
		#"west":
			#list = possible_west
	#return list[choice][GlobalRandomNumberGenerator.randi_range(0, list[choice].size() - 1)]
