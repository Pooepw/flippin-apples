extends Control

# access nodes
var inventory_system

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	inventory_system = get_node("InventorySystem")

func set_weapon_slot(new_weapon):
	inventory_system.add_to_inventory(new_weapon)
