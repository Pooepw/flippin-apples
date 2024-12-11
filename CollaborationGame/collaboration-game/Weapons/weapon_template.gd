extends Node2D

class_name weapon

var weapon_icon

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	weapon_icon = get_node("WeaponIcon")
	weapon_icon.visible = true

func start_attack():
	pass

func end_attack():
	pass

func place_weapon_on_floor():
	weapon_icon.visible = true
