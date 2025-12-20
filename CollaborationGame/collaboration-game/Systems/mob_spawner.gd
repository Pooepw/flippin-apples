extends Node2D

class_name mob_spawner_class

var mob_type: MobGenerator.MOB_TYPES = MobGenerator.MOB_TYPES.GROSS

var num_mobs_to_spawn = 0

var mob_count = 0

var spawn_timer
var spawning_mobs = false
const SPAWN_TIME = 1
const SPAWN_CEIL = 5
const SPAWN_FLOOR = 2

var emptied = false

var boss_dict = {MobGenerator.MOB_TYPES.GROSS: "res://NPCs/Mobs/Bosses/gross_boss.tscn",
				   MobGenerator.MOB_TYPES.SHAPE: "res://NPCs/Mobs/Bosses/shape_boss.tscn",
				   MobGenerator.MOB_TYPES.SOMEBODY: "res://NPCs/Mobs/Bosses/somebody_boss.tscn",
				   MobGenerator.MOB_TYPES.YOU: "res://NPCs/Mobs/Bosses/you_purple_boss.tscn"}

var group_parent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_timer = get_node("SpawnTimer")
	if get_parent() is mob_group:
		group_parent = get_parent()

func spawn_mob():
	num_mobs_to_spawn -= 1
	mob_count += 1
	var options = MobGenerator.current_mob_pool.size() - 1
	var mob_choice = MobGenerator.current_mob_pool[GlobalRandomNumberGenerator.rng.randi_range(0, options)]
	var mob_node = load(mob_choice)
	var mob_instance = mob_node.instantiate()
	add_child(mob_instance)
	mob_instance.global_position = global_position
	mob_instance.mob_spawner_parent = self

func _process(_delta: float) -> void:
	if mob_count == 0 and num_mobs_to_spawn == 0:
		emptied = true

func _on_spawn_timer_timeout() -> void:
	if num_mobs_to_spawn > 0 and spawning_mobs:
		spawn_mob()
		spawn_timer.start(SPAWN_TIME)
	else:
		spawning_mobs = false

func start_spawning():
	print("spawning mobs")
	spawning_mobs = true
	spawn_timer.start(SPAWN_TIME)

func spawn_boss(mob_to_boss):
	if not mob_to_boss.mob_type == MobGenerator.MOB_TYPES.YOU:
		var boss_effects = load(boss_dict[mob_to_boss.mob_type]).instantiate()
		mob_to_boss.add_child(boss_effects)
		boss_effects.set_up_boss()
#	else do nothing (the you boss is already a boss)

func set_up_spawn():
	num_mobs_to_spawn = GlobalRandomNumberGenerator.rng.randi_range(SPAWN_FLOOR, SPAWN_CEIL)

func mob_died():
	mob_count -= 1
	if mob_count == 0 and num_mobs_to_spawn == 0:
		group_parent.spawner_cleared()
