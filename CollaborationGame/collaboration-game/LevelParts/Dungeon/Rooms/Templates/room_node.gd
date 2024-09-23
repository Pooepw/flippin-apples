extends Node2D

class_name room

@export var north_room_closed: bool
@export var south_room_closed: bool
@export var east_room_closed: bool
@export var west_room_closed: bool

var grid_location = Vector2(0, 0)

func close_off(side):
	side = true

func rooms_closed():
	return (north_room_closed and south_room_closed 
	and east_room_closed and west_room_closed)


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
