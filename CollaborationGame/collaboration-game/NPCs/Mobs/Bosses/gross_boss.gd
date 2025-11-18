extends boss_mob

const TIME_LOW = 3.0
const TIME_HI = 8.0
var attack_timer_node

func _ready():
	super()
	boss_attack_node = get_node("GrossBossAttack")
	attack_timer_node = get_node("AttackTimer")
	var attack_time = GlobalRandomNumberGenerator.rng.randf_range(TIME_LOW, TIME_HI)
	attack_timer_node.start(attack_time)

func _on_attack_timer_timeout() -> void:
	boss_attack_node.perform_attack()
	var attack_time = GlobalRandomNumberGenerator.rng.randf_range(TIME_LOW, TIME_HI)
	attack_timer_node.start(attack_time)
