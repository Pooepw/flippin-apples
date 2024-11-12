extends Node2D

var inventory = []
var inventory_size = 3 # this will probably change based on character class
var slot_number = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for int in range(0, inventory_size - 1):
		inventory.push_back(0)

func add_to_inventory(new_weapon):
	if inventory[slot_number] is int:
		inventory[slot_number] = new_weapon
	else:
		inventory[slot_number].queue_free()
		inventory[slot_number] = new_weapon
