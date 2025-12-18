extends Control

var inventory = []
var inventory_size = 3 # this will probably change based on character class
var slot_number = 0
var slot_dictionary = {0: "Weapon1", 1: "Weapon2", 2: "Weapon3"}

var weapon_indicator = preload("res://Interfaces/UIAssets/weapon_active_indicator.tscn").instantiate()
var inventory_ui

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for space in range(0, inventory_size):
		inventory.push_back("clear")
	inventory_ui = get_node("InventoryUI")
	inventory_ui.get_node("Weapon1").add_child(weapon_indicator)
	print(inventory)

func add_to_inventory(new_weapon):
	var new_weapon_instance = load(new_weapon).instantiate()
	new_weapon_instance.set_up_basic_weapon_things()
	new_weapon_instance.weapon_icon.visible = false
	var to_slot = find_slot_for_weapon_insertion()
	if inventory[to_slot] is weapon2:
		inventory[to_slot].queue_free()
	inventory[to_slot] = new_weapon_instance
	var weapon_texture = new_weapon_instance.weapon_icon.get_texture()
	inventory_ui.get_node(slot_dictionary[to_slot]).set_texture(weapon_texture)
	if not PlayerHandler.current_player.weapon_equipped() or to_slot == slot_number:
		swap_weapon(to_slot)

func swap_weapon(to_slot):
	inventory_ui.get_node(slot_dictionary[slot_number]).remove_child(weapon_indicator)
	slot_number = to_slot
	inventory_ui.get_node(slot_dictionary[slot_number]).add_child(weapon_indicator)
	var to_weapon = inventory[to_slot]
	PlayerHandler.current_player.swap_weapon(to_weapon)
	

func find_slot_for_weapon_insertion():
	if not inventory[0] is weapon2:
		return 0
	if not inventory[1] is weapon2:
		return 1
	if not inventory[2] is weapon2:
		return 2
	return slot_number
