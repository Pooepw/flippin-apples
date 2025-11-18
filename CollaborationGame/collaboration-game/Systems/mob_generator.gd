extends Node


var current_mob_pool = []
var all_mobs

var floor_bonus = 0
var cycle_bonus = 0

enum MOB_TYPES {GROSS, SHAPE, SOMEBODY, YOU}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_mob_pool.append_array(FileReader.open_and_read_file("res://NPCs/Mobs/MobsLists/Level1Mobs.txt"))

func add_to_pool(mob_pool: String):
	var pool = FileReader.open_and_read_file(mob_pool)
	current_mob_pool.append_array(pool)
