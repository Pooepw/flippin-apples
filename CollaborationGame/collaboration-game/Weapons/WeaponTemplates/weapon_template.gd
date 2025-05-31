extends Node2D

class_name weapon

@export var weapon_name: String
var weapon_icon
var attack_states

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	weapon_icon = get_node("WeaponIcon")
	weapon_icon.visible = true

func _physics_process(delta: float) -> void:
	if PlayerHandler.current_player.direction.x < 0:
		attack_states.flip_h = false
	if PlayerHandler.current_player.direction.x > 0:
		attack_states.flip_h = true

func start_attack():
	pass

func end_attack():
	pass

func place_weapon_on_floor():
	weapon_icon.visible = true
