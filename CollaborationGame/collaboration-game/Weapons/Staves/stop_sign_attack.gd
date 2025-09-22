extends staff_attack

var attack_area
var stop_timer

const STOP_TIME = 2

func perform_attack(emitted_by, damage):
	set_up_emitter(emitted_by)
	set_up_hit_area()
	ProjectileHandler.add_child(self)
	position = get_global_mouse_position()
	stop_timer = get_node("StopTimer")
	stop_timer.start(STOP_TIME)

func set_up_hit_area():
	attack_area = get_node("AttackArea")
	if emitter == CollisionHandler.EMITTER_TYPES.PLAYER:
		attack_area.set_collision_layer_value(1, false)
		attack_area.set_collision_mask_value(1, false)
		attack_area.set_collision_layer_value(7, true)
		attack_area.set_collision_mask_value(3, true)
		attack_area.set_collision_mask_value(5, true)
		attack_area.set_collision_mask_value(6, true)
	else:
		attack_area.set_collision_layer_value(1, false)
		attack_area.set_collision_mask_value(7, true)
		attack_area.set_collision_mask_value(3, true)
		attack_area.set_collision_layer_value(5, true)
		attack_area.set_collision_layer_value(5, true)

func _on_attack_area_body_entered(body: Node2D) -> void:
	if body is mob:
		body.current_speed = 0
	else:
		PlayerHandler.current_player.current_speed = 0


func _on_attack_area_body_exited(body: Node2D) -> void:
	if body is mob:
		body.current_speed = body.move_speed
	else:
		PlayerHandler.current_player.current_speed = PlayerHandler.current_player.speed

func _on_stop_timer_timeout() -> void:
	queue_free()
