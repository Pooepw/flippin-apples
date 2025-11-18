extends Node2D

class_name mob_spawner_class

var num_mobs_to_spawn = 0

var mob_count = 0

var spawn_timer
var spawning_mobs = false
const SPAWN_TIME = 3

var boss_dict = {MobGenerator.MOB_TYPES.GROSS: "res://NPCs/Mobs/Bosses/gross_boss.tscn",
				   MobGenerator.MOB_TYPES.SHAPE: "",
				   MobGenerator.MOB_TYPES.SOMEBODY: "",
				   MobGenerator.MOB_TYPES.YOU: ""}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_timer = get_node("SpawnTimer")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	if spawn_timer.is_stopped() and num_mobs_to_spawn > 0 and spawning_mobs:
		spawn_timer.start(SPAWN_TIME)
		

func spawn_mob():
	num_mobs_to_spawn -= 1
	mob_count += 1
	var options = MobGenerator.current_mob_pool.size() - 1
	var mob_choice = MobGenerator.current_mob_pool[GlobalRandomNumberGenerator.rng.randi_range(0, options)]
	var mob_node = load(mob_choice)
	var mob_instance = mob_node.instantiate()
	mob_instance.position = position
	mob_instance.mob_spawner_parent = self
	add_child(mob_instance)

func _on_spawn_timer_timeout() -> void:
	spawn_mob()

func start_spawning():
	print("spawning mobs")
	spawning_mobs = true

func spawn_boss(mob_to_boss):
	# this for now
	var test_mob = load("res://NPCs/Mobs/GrossDungeon/flaming_eye_stalk.tscn").instantiate()
	if not test_mob.mob_type == MobGenerator.MOB_TYPES.YOU:
		var boss_effects = load(boss_dict[test_mob.mob_type]).instantiate()
		test_mob.add_child(boss_effects)
		boss_effects.set_up_boss()
		MobGenerator.add_child(test_mob)
	#if not mob_to_boss.mob_type == MobGenerator.MOB_TYPES.YOU:
		#var boss_effects = load(boss_dict[mob_to_boss.mob_type]).instantiate()
		#mob_to_boss.add_child(boss_effects)
		#boss_effects.set_up_boss()
