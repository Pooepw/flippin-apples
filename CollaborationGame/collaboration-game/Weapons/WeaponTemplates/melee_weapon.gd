extends weapon

class_name melee_weapon

# basic melee weapon stats
# stamina cost to swing the weapon
@export var stamina_cost: int
# damage the weapon does when it is swung
@export var damage: int

var attacking

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
