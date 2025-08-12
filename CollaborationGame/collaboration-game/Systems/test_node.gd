extends Node

var file_test

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerHandler.set_up_player()
	file_test = get_node("FileTest")


func _on_file_test_pressed() -> void:
	var test_rooms = FileReader.open_and_read_room_file("res://RoomsLists/MedievalRooms/MedievalRoomsEast.txt")
	print(test_rooms)



func _on_gen_dungeon_test_pressed() -> void:
	DungeonGenerator.generate_dungeon("res://LevelParts/Dungeon/Rooms/Medieval/medieval_starting_room_1.tscn", 3)


func _on_inventory_test_pressed() -> void:
	var test_weapon = load("res://Weapons/Guns/the_nose.tscn")
	var test_weapon_instance = test_weapon.instantiate()
	PlayerHandler.current_player.equip_weapon(test_weapon_instance)


func _on_mob_spawn_test_pressed() -> void:
	var test_mob = load("res://NPCs/Mobs/test_hopper.tscn")
	var test_mob_instance = test_mob.instantiate()
	test_mob_instance.position = Vector2(0,0)
	MobGenerator.add_child(test_mob_instance)
