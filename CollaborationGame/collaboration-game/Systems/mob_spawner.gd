extends Node2D

var num_mobs_to_spawn = 0

var mob_count = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn_mob():
	var options = MobGenerator.current_mob_pool.size() - 1
	var mob = MobGenerator.current_mob_pool[GlobalRandomNumberGenerator.rng.randi_range(0, options)]

func _on_spawn_timer_timeout() -> void:
	pass # Replace with function body.
