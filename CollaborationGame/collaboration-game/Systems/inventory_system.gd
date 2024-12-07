extends Control

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
	var weapon_instance = new_weapon.instantiate()
	Player.add_child(weapon_instance)
	weapon_instance.weapon_icon.visible = false
	if inventory[slot_number] is int:
		inventory[slot_number] = weapon_instance
	else:
		inventory[slot_number].queue_free()
		inventory[slot_number] = weapon_instance
	var weapon_texture = weapon_instance.weapon_icon.get_texture()
	match slot_number:
		0:
			inventory_ui.get_node("Weapon1").set_texture(weapon_texture)
		1:
			inventory_ui.get_node("Weapon2").set_texture(weapon_texture)
		2:
			inventory_ui.get_node("Weapon3").set_texture(weapon_texture)
