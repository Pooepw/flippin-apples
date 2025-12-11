extends Node2D

class_name room

@export var north_room_closed: bool
@export var south_room_closed: bool
@export var east_room_closed: bool
@export var west_room_closed: bool

var grid_location = Vector2(0, 0)

var room_aspect: DungeonGenerator.ROOM_EFFECTS = DungeonGenerator.ROOM_EFFECTS.NOTHING
var doors_node
var mob_spawner_group_node

# treasure spawnable
var weapon_pedestal_node
var weapon_loot_node
var treasure_point_position

func _ready():
	if not self is starting_room:
		mob_spawner_group_node = get_node("MobGroup")
		treasure_point_position = get_node("TreasurePoint").position
	#get_node("TextureRect").visible = false


func set_up_room_aspect():
	if room_aspect == DungeonGenerator.ROOM_EFFECTS.MOBS:
		mob_spawner_group_node.set_up_spawns()
	if room_aspect == DungeonGenerator.ROOM_EFFECTS.TREASURE:
		weapon_pedestal_node = load("res://LevelParts/Dungeon/LevelComponents/weapon_pedestal.tscn")
		weapon_loot_node = load("res://LevelParts/Dungeon/LevelComponents/weapon_loot.tscn")
		var loot = LootGenerator.generate_loot()
		var weapon_loot_instance = weapon_loot_node.instantiate()
		weapon_loot_instance.set_up_loot(loot)
		var weapon_pedestal_instance = weapon_pedestal_node.instantiate()
		weapon_pedestal_instance.add_child(weapon_loot_instance)
		weapon_pedestal_instance.weapon_loot = weapon_loot_instance
		add_child(weapon_pedestal_instance)
		weapon_pedestal_instance.position = treasure_point_position


func activate_room_aspect():
	if room_aspect == DungeonGenerator.ROOM_EFFECTS.MOBS:
		print("spawning mobs")
		mob_spawner_group_node.activate_spawners()
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
 
