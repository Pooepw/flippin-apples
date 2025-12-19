extends staff_attack

var attack_area
var life_timer

func perform_attack(emitted_by, damage):
	set_up_emitter(emitted_by)
	set_up_hit_area()
	ProjectileHandler.add_child(self)
	position = get_global_mouse_position()
	life_timer = get_node("LifeTimer")
	life_timer.start()

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
	CollisionHandler.handle_collision(self, body)


func _on_life_timer_timeout() -> void:
	queue_free()


func _on_attack_area_area_entered(area: Area2D) -> void:
	CollisionHandler.handle_collision(self, area)
