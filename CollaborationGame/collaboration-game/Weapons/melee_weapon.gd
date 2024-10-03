extends weapon

class_name melee_weapon

# stamina cost to swing the weapon
@export var stamina_cost: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func attack():
	Player.current_stamina -= stamina_cost
