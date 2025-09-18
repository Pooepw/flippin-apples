extends staff_attack

var shocker_frames
var shock_timer
var shock_area
var attack_damage

const SHOCK_TIME = 2

func perform_attack(emitted_by, damage):
	shocker_frames = get_node("ShockerFrames")
	shock_timer = get_node("ShockTimer")
	shock_area = get_node("ShockArea")
	shock_area.monitoring = false
	attack_damage = damage
	if emitted_by is player:
		emitter = CollisionHandler.EMITTER_TYPES.PLAYER
	else: 
		emitter = CollisionHandler.EMITTER_TYPES.MOB
	set_up_hit_area()
	ProjectileHandler.add_child(self)
	position = get_global_mouse_position()
	shocker_frames.play("Drop")

func _on_shocker_frames_animation_finished() -> void:
	if shocker_frames.animation == "Drop":
		shocker_frames.play("Strike")
	elif shocker_frames.animation == "Strike":
		enact_shock()
		shocker_frames.visible = false

func enact_shock():
	shock_timer.start(SHOCK_TIME)
	shock_area.monitoring = true

func _on_shock_timer_timeout() -> void:
	queue_free()

func set_up_hit_area():
	if emitter == CollisionHandler.EMITTER_TYPES.PLAYER:
		shock_area.set_collision_layer_value(1, false)
		shock_area.set_collision_mask_value(1, false)
		shock_area.set_collision_layer_value(7, true)
		shock_area.set_collision_mask_value(3, true)
		shock_area.set_collision_mask_value(5, true)
		shock_area.set_collision_mask_value(6, true)
	else:
		shock_area.set_collision_layer_value(1, false)
		shock_area.set_collision_mask_value(7, true)
		shock_area.set_collision_mask_value(3, true)
		shock_area.set_collision_layer_value(5, true)
		shock_area.set_collision_layer_value(5, true)


func _on_shock_area_body_entered(body: Node2D) -> void:
	CollisionHandler.handle_collision(self, body)
