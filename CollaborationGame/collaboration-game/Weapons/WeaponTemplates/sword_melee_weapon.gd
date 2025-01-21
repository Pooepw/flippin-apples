extends melee_weapon

class_name sword

@export var swing_time: float
@export var cooldown_time: float
var swing_timer
var hit_timer

var hitbox
var slash_states
var hitbox_frames


func _ready() -> void:
	super()
	hitbox = get_node("Hitbox")
	hitbox.monitoring = false
	slash_states = get_node("AttackStates")
	hitbox_frames = get_node("HitboxFrames")
	hitbox_frames.visible = false
	swing_timer = get_node("SwingTimer")
	hit_timer = get_node("HitTimer")


func _physics_process(delta: float) -> void:
	hitbox_frames.position = position + (position.direction_to(get_local_mouse_position()) * 100)
	hitbox_frames.rotation = get_global_mouse_position().angle_to_point(global_position)

func start_attack():
	if swing_timer.is_stopped() and hit_timer.is_stopped():
		slash_states.frame = 1
		swing_timer.start(swing_time)
	
func end_attack():
	slash_states.frame = 0
	swing_timer.stop()
	
func _on_swing_timer_timeout_do_attack():
	slash_states.frame = 2
	hit_timer.start(cooldown_time)
	hitbox_frames.visible = true
	hitbox_frames.play()
	hitbox.monitoring = true

func _on_hit_timer_timeout() -> void:
	slash_states.frame = 1
	hitbox.monitoring = false
	hitbox_frames.visible = false
	swing_timer.start(swing_time)
