extends Node2D

var inventory = []
var inventory_size = 3 # this will probably change based on character class
var slot_number = 0

var inventory_ui

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for int in range(0, inventory_size - 1):
		inventory.push_back(0)
	inventory_ui = get_node("InventoryUI")

func add_to_inventory(new_weapon):
	if inventory[slot_number] is int:
		inventory[slot_number] = new_weapon
	else:
		inventory[slot_number].queue_free()
		inventory[slot_number] = new_weapon
	match slot_number:
		0:
			print(inventory_ui.get_node("Weapon1").get_texture())
			inventory_ui.get_node("Weapon1").set_texture(new_weapon.weapon_icon.get_texture())
		1:
			inventory_ui.get_node("Weapon2").texture = new_weapon.weapon_icon.texture
		2:
			inventory_ui.get_node("Weapon3").texture = new_weapon.weapon_icon.texture
