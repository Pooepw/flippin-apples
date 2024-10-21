extends Node2D

class_name mob_spawner_class

var num_mobs_to_spawn = 0

var mob_count = 0

var spawn_timer
var spawning_mobs = false
const SPAWN_TIME = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_timer = get_node("SpawnTimer")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if spawn_timer.is_stopped() and num_mobs_to_spawn > 0:
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
	spawn_timer.start(SPAWN_TIME)
