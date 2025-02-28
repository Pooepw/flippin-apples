extends Node2D

class_name room

@export var north_room_closed: bool
@export var south_room_closed: bool
@export var east_room_closed: bool
@export var west_room_closed: bool

var grid_location = Vector2(0, 0)

var room_aspect
var doors_node

func activate_room_aspect():
	if room_aspect is mob_spawner_class:
		room_aspect.start_spawning()
		activate_doors()
		
func activate_doors():
	doors_node.process_mode = Node.PROCESS_MODE_ALWAYS
	doors_node.visible = true
	if north_room_closed:
		var north_door = doors_node.get_node("MedievalNorthDoor")
		north_door.visible = false
	if south_room_closed:
		var south_door = doors_node.get_node("MedievalSouthDoor")
		south_door.visible = false
	if east_room_closed:
		var east_door = doors_node.get_node("MedievalEastDoor")
		east_door.visible = false
	if west_room_closed:
		var west_door = doors_node.get_node("MedievalWestDoor")
		west_door.visible = false
