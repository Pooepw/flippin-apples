extends boss_mob

var shape_boss_attack
var wait_timer

const FIRING_TIME = 4
const WAITING_TIME = 8


func _ready() -> void:
	super()
	shape_boss_attack = get_node("ShapeBossAttack")
	wait_timer = get_node("WaitTimer")
	wait_timer.start(WAITING_TIME)

func _on_wait_timer_timeout() -> void:
	if shape_boss_attack.firing:
		print("beam halted")
		wait_timer.start(WAITING_TIME)
		shape_boss_attack.firing = false
	else:
		print("started firing beam")
		wait_timer.start(FIRING_TIME)
		shape_boss_attack.start_firing()
