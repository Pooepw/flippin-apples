extends Node2D

var current_loot_list = []

func add_loot_list(loot_list):
	current_loot_list.append_array(loot_list)
	current_loot_list.shuffle()

func pick_loot():
	var weapon_decision = GlobalRandomNumberGenerator.rng.randi_range(0, current_loot_list.size() - 1)
	var weapon_node = current_loot_list[weapon_decision]
	return weapon_node

func generate_weapon_loot():
	var weapon_choice = pick_loot()
	return weapon_choice
	
func generate_loot():
	return generate_weapon_loot()

func clear_table():
	current_loot_list.clear()
