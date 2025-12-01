extends Node2D

class_name mob_group

var spawners = []

func _ready():
	spawners = get_children()

func set_up_spawns():
	for spawner in spawners:
		spawner.set_up_spawn()

func activate_spawners():
	for spawner in spawners:
		spawner.start_spawning()
