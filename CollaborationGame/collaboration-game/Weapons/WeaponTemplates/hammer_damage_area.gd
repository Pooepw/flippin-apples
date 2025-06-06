extends Node2D

class_name hammer_damage_area

@export var strike_time: float
@export var shock_time: float

var emitter

var damage_dealt = 0

var shock_area
var strike_area

var shock_timer
var strike_timer


func project_wave(to_position, outward_distance, emitted_by, damage): 
	if emitted_by is player:
		emitter = CollisionHandler.EMITTER_TYPES.PLAYER
	else: 
		emitter = CollisionHandler.EMITTER_TYPES.MOB
	position = emitted_by.global_position
	var direction = position.direction_to(to_position)
	position += direction * outward_distance
	set_up_nodes()
	set_up_hit_areas()
	damage_dealt = damage
	ProjectileHandler.add_child(self)
	strike_timer.start(strike_time)
	
func set_up_nodes():
	shock_area = get_node("ShockwaveArea")
	strike_area = get_node("StrikeArea")
	
	shock_timer = get_node("ShockwaveTimer")
	strike_timer = get_node("StrikeTimer")
	
func set_up_hit_areas():
	if emitter == CollisionHandler.EMITTER_TYPES.PLAYER:
		shock_area.set_collision_layer_value(1, false)
		shock_area.set_collision_mask_value(1, false)
		shock_area.set_collision_layer_value(7, true)
		shock_area.set_collision_mask_value(3, true)
		shock_area.set_collision_mask_value(5, true)
		shock_area.set_collision_mask_value(6, true)
		
		strike_area.set_collision_layer_value(1, false)
		strike_area.set_collision_mask_value(1, false)
		strike_area.set_collision_layer_value(7, true)
		strike_area.set_collision_mask_value(3, true)
		strike_area.set_collision_mask_value(5, true)
		strike_area.set_collision_mask_value(6, true)
	else:
		shock_area.set_collision_layer_value(1, false)
		shock_area.set_collision_mask_value(7, true)
		shock_area.set_collision_mask_value(3, true)
		shock_area.set_collision_layer_value(5, true)
		shock_area.set_collision_layer_value(5, true)
		
		strike_area.set_collision_layer_value(1, false)
		strike_area.set_collision_mask_value(7, true)
		strike_area.set_collision_mask_value(3, true)
		strike_area.set_collision_layer_value(5, true)
		strike_area.set_collision_layer_value(5, true)


func _on_strike_timer_timeout_shock():
	print("strike_ended")
	strike_area.monitoring = false
	shock_timer.start(shock_time)
	
func _on_shock_timer_timout_die():
	queue_free()


func _on_shockwave_area_body_entered(body: Node2D) -> void:
	CollisionHandler.handle_melee_strike(self, body, damage_dealt / 2)
	

func _on_strike_area_body_entered(body: Node2D) -> void:
	CollisionHandler.handle_melee_strike(self, body, damage_dealt)
