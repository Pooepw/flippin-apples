extends Node

# this node will have every room so all the nodes are loaded in before generating a dungeon.
# this way, each room will not have to load every node it can connect to.

# medieval rooms
var medieval_north = {1: [], 2: [], 3:[], 4:[]}
var medieval_south = {1: [], 2: [], 3:[], 4:[]}
var medieval_east = {1: [], 2: [], 3:[], 4:[]}
var medieval_west = {1: [], 2: [], 3:[], 4:[]}
var medieval_exits = {"N": [], "S": [], "E": [], "W": []}
var medieval_doors = preload("res://LevelParts/Dungeon/Rooms/Medieval/medieval_doors.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# all rooms set up here
	set_up_medieval_rooms()

# populates a dictionary of rooms by determining how many openings it has and 
# putting it into an array paired with that amount of openings.
func populate_list(text, list):
	for room_node in text:
		var loaded_room = load(room_node)
		var temp_room = loaded_room.instantiate()
		var openings = ((1 if not temp_room.north_room_closed else 0) + 
		(1 if not temp_room.south_room_closed else 0) +
		(1 if not temp_room.east_room_closed else 0) +
		(1 if not temp_room.west_room_closed else 0))
		list[openings].push_back(loaded_room)
		temp_room.queue_free()
	#print(list)

# set up the medieval rooms dictionaries with the amount of openings each room has and their amount of 
func set_up_medieval_rooms():
	var medieval_north_text = FileReader.open_and_read_room_file("res://RoomsLists/MedievalRooms/MedievalRoomsNorth.txt")
	populate_list(medieval_north_text, medieval_north)
	var medieval_south_text = FileReader.open_and_read_room_file("res://RoomsLists/MedievalRooms/MedievalRoomsSouth.txt")
	populate_list(medieval_south_text, medieval_south)
	var medieval_east_text = FileReader.open_and_read_room_file("res://RoomsLists/MedievalRooms/MedievalRoomsEast.txt")
	populate_list(medieval_east_text, medieval_east)
	var medieval_west_text = FileReader.open_and_read_room_file("res://RoomsLists/MedievalRooms/MedievalRoomsWest.txt")
	populate_list(medieval_west_text, medieval_west)
	var n_room = load("res://LevelParts/Dungeon/Rooms/Medieval/medieval_exit_room_n.tscn")
	var s_room = load("res://LevelParts/Dungeon/Rooms/Medieval/medieval_exit_room_s.tscn")
	var e_room = load("res://LevelParts/Dungeon/Rooms/Medieval/medieval_exit_room_e.tscn")
	var w_room = load("res://LevelParts/Dungeon/Rooms/Medieval/medieval_exit_room_w.tscn")
	medieval_exits["N"].push_back(n_room)
	medieval_exits["S"].push_back(s_room)
	medieval_exits["E"].push_back(e_room)
	medieval_exits["W"].push_back(w_room)
	
