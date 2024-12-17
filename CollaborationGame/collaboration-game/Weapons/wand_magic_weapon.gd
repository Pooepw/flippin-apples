extends magic_weapon

class_name wand

@export var projectile_scene: String
var projectile_node



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	projectile_node = load(projectile_scene)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if casting:
		if not cast_started:
			cast_started = true
			cast_timer.start()
			

func _on_cast_timer_timeout() -> void:
	Player.current_mana -= mana_cost
	var projectile_instance = projectile_node.instantiate()
	projectile_instance.emitter = "player"
	# gdi godot
	projectile_instance.set_collision_layer_value(1, false)
	projectile_instance.set_collision_mask_value(1, false)
	projectile_instance.set_collision_layer_value(7, true)
	projectile_instance.set_collision_mask_value(3, true)
	projectile_instance.set_collision_mask_value(5, true)
	projectile_instance.set_collision_mask_value(6, true)
	projectile_instance.set_up_movement(get_global_mouse_position())
	projectile_instance.actual_damage = projectile_instance.damage
	ProjectileHandler.add_child(projectile_instance)
	projectile_instance.get_node("LiveTimer").start()
	cast_started = false
