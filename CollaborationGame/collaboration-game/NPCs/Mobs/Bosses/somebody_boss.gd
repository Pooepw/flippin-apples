extends boss_mob

var tree_attack = preload("res://NPCs/Mobs/Bosses/tree.tscn")
var attack_timer
const ATTACK_TIME = 6

func _ready():
	super()
	attack_timer = get_node("AttackTimer")
	attack_timer.start(ATTACK_TIME)

func _on_attack_timer_timeout() -> void:
	var tree_attack_instance = tree_attack.instantiate()
	ProjectileHandler.add_child(tree_attack_instance)
	attack_timer.start(ATTACK_TIME)
