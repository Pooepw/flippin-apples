extends Node2D

class_name sword_damage_area

@export var afterslash_duration: float

var emitter

var damage_dealt = 0

var swing_area

func project_wave(to_position, outward_distance, emitted_by, damage): 
	if emitted_by is player:
		emitter = CollisionHandler.EMITTER_TYPES.PLAYER
	else: 
		emitter = CollisionHandler.EMITTER_TYPES.MOB
	position = emitted_by.global_position
	var direction = position.direction_to(to_position)
	position += direction * outward_distance
	set_up_hit_area()
	damage_dealt = damage
	ProjectileHandler.add_child(self)

func set_up_hit_area():
	swing_area = get_node("SwingArea")
	if emitter == CollisionHandler.EMITTER_TYPES.PLAYER:
		swing_area.set_collision_layer_value(1, false)
		swing_area.set_collision_mask_value(1, false)
		swing_area.set_collision_layer_value(7, true)
		swing_area.set_collision_mask_value(3, true)
		swing_area.set_collision_mask_value(5, true)
		swing_area.set_collision_mask_value(6, true)
	else:
		swing_area.set_collision_layer_value(1, false)
		swing_area.set_collision_mask_value(7, true)
		swing_area.set_collision_mask_value(3, true)
		swing_area.set_collision_layer_value(5, true)
		swing_area.set_collision_layer_value(5, true)

func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()

func _on_swing_area_body_entered(body: Node2D) -> void:
	CollisionHandler.handle_melee_strike(self, body, damage_dealt)
