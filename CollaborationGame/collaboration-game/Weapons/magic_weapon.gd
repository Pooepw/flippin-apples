extends weapon

class_name magic_weapon

# cost to cast this weapon
@export var mana_cost: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()

func attack():
	Player.current_mana -= mana_cost
