extends magic_weapon

class_name wand

@export var projectile_scene: String

var projectile_node
var attack_states


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	projectile_node = load(projectile_scene)
	attack_states = get_node("AttackStates")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if casting:
		attack_states.frame = 1
		if not cast_started:
			cast_started = true
			cast_timer.start(cast_time)
	elif not casting:
		attack_states.frame = 0
		if cast_started:
			cast_timer.stop()
			cast_started = false


func _on_cast_timer_timeout() -> void:
	PlayerHandler.current_player.current_mana -= mana_cost
	var projectile_instance = projectile_node.instantiate()
	projectile_instance.fire_self(get_global_mouse_position(), player)
	cast_started = false
