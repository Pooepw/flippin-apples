extends mob

var enemy_body
var antenna_shock_attack_node = preload("res://Weapons/Staves/antenna_shocker_attack.tscn")
var player_in_range = false
const ATTACK_DAMAGE = 50

func _ready():
	enemy_body = get_node("EnemyBody")
	enemy_body.play("Idle")

func _on_vision_range_body_entered(body: Node2D) -> void:
	if body is player:
		enemy_body.stop()
		enemy_body.play("Firing")
		player_in_range = true
	

func _on_vision_range_body_exited(body: Node2D) -> void:
	if body is player:
		enemy_body.stop()
		enemy_body.play("Idle")
		player_in_range = false

func _on_enemy_body_animation_finished() -> void:
	if enemy_body.animation == "Firing":
		var emission_instance = antenna_shock_attack_node.instantiate()
		emission_instance.perform_attack(get_parent(), ATTACK_DAMAGE)
		enemy_body.play("Firing")
