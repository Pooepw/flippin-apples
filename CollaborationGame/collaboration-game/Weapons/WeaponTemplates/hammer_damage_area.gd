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

var real_strike_time
var real_shock_time

func project_wave(to_position, outward_distance, emitted_by, charge, damage): 
	if emitted_by is player:
		emitter = CollisionHandler.EMITTER_TYPES.PLAYER
	else: 
		emitter = CollisionHandler.EMITTER_TYPES.MOB
	position = emitted_by.global_position
	var direction = position.direction_to(to_position)
	var new_angle = position.angle_to_point(to_position)
	rotation = new_angle
	position += direction * outward_distance
	set_up_nodes()
	set_up_hit_areas()
	damage_dealt = damage
	ProjectileHandler.add_child(self)
	real_strike_time = strike_time * charge
	real_shock_time = shock_time if charge == 1 else 0.0
	set_area_status(strike_area, true)
	strike_timer.start(real_strike_time)


func set_up_nodes():
	shock_area = get_node("ShockwaveArea")
	strike_area = get_node("StrikeArea")
	
	set_area_status(shock_area, false)
	set_area_status(strike_area, false)
	
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


func set_area_status(area, status):
	area.monitoring = status
	area.visible = status

func _on_strike_timer_timeout_shock():
	print("strike_ended")
	set_area_status(strike_area, false)
	if real_shock_time > 0:
		set_area_status(shock_area, true)
		shock_timer.start(shock_time)
	else: 
		queue_free()
	
func _on_shock_timer_timout_die():
	queue_free()


func _on_shockwave_area_body_entered(body: Node2D) -> void:
	CollisionHandler.handle_melee_strike(self, body, damage_dealt / 2)

func _on_strike_area_body_entered(body: Node2D) -> void:
	CollisionHandler.handle_melee_strike(self, body, damage_dealt)
