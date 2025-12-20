extends Node2D

class_name mob_group

var spawners = []
var room_parent
var spawners_left

func _ready():
	spawners = get_children()
	room_parent = get_parent()
	spawners_left = spawners.size()

func set_up_spawns():
	for spawner in spawners:
		spawner.set_up_spawn()

func activate_spawners():
	for spawner in spawners:
		spawner.start_spawning()

func spawner_cleared():
	spawners_left -= 1
	if spawners_left == 0:
		room_parent.deactivate_doors()
