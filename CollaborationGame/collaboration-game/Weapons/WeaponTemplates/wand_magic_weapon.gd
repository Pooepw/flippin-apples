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
	projectile_instance.fire_self(get_global_mouse_position(), player)
	cast_started = false
