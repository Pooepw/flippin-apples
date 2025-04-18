extends Control

# access nodes
var inventory_system
var player_stats
var dialogue_interface

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	inventory_system = get_node("InventorySystem")
	player_stats = get_node("PlayerStats")
	dialogue_interface = get_node("DialogueInterface")
	dialogue_interface.visible = false

func activate_dialogue():
	dialogue_interface.visible = true

func set_weapon_slot(new_weapon):
	inventory_system.add_to_inventory(new_weapon)
