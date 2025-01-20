extends melee_weapon

class_name sword

@export var swing_time: float
var swing_timer

var hitbox

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	hitbox = get_node("Hitbox")
	hitbox.monitoring = false
	swing_timer = get_node("SwingTimer")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	pass

func start_attack():
	if swing_timer.paused:
		swing_timer.start(swing_time)
		
	
func end_attack():
	if swing_timer.time_left == 0:
		swing_timer.stop()
	
func _on_swing_timer_timeout_do_attack():
	pass
	# insert the attack animation here
