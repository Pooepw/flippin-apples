extends staff_attack

var attack_area
var live_timer
const live_time = 4

var emitter_node

func _ready():
	global_position = PlayerHandler.current_player.global_position
	attack_area = get_node("Area2D")
	set_up_hit_area()
	live_timer = get_node("LiveTimer")
	emitter_node = get_node("CPUParticles2D")
	emitter_node.emitting = false
	get_node("AnimatedSprite2D").play()
	

func _on_animated_sprite_2d_animation_finished() -> void:
	attack_area.monitoring = true
	attack_area.monitorable = true
	emitter_node.emitting = true
	live_timer.start(live_time)

func _on_live_timer_timeout() -> void:
	queue_free()

func set_up_hit_area():
	emitter = CollisionHandler.EMITTER_TYPES.MOB
	attack_area.monitoring = false
	attack_area.monitorable = false
	attack_area.set_collision_layer_value(1, false)
	attack_area.set_collision_mask_value(7, true)
	attack_area.set_collision_mask_value(3, true)
	attack_area.set_collision_layer_value(5, true)
	attack_area.set_collision_layer_value(5, true)
