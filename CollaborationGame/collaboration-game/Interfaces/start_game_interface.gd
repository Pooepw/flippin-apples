extends Control

var weapon_start_list

const WEAPON_START_DOC = "res://Weapons/UnlockedWeapons.txt"

var weapon_dict = {}

func _ready():
	weapon_start_list = get_node("WeaponStartList")
	var weapon_strings = FileReader.open_and_read_file(WEAPON_START_DOC)
	for string in weapon_strings:
		var temp_instance = load(string).instantiate()
		var name_weapon = temp_instance.weapon_name
		weapon_dict.set(name_weapon, string)
		temp_instance.queue_free()
		weapon_start_list.add_item(name_weapon)
