extends Node2D

var stash_size = 20
var weapon_amount = 0
var weapon_list = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func add_weapon(weapon_data):
	var weapon_name = weapon_data.weapon_name
	var weapon_icon = weapon_data.weapon_icon
	var weapon_path = weapon_data.scene_file_path
	var packed_weapon  = [weapon_name, weapon_icon, weapon_path]
	weapon_list.append(packed_weapon)
