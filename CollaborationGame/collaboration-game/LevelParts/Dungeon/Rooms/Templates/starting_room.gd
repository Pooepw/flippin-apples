extends room

@export var dungeon_type: String

## call to make a dungeon with recursion.
#func generate_dungeon(max_distance):
	#if not north_room_closed:
		#pick_room("north")
