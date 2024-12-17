extends weapon

class_name magic_weapon

# cost to cast this weapon
@export var mana_cost: int
@export var cast_time: float

var casting = false
var cast_started = false
var cast_timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	cast_timer = get_node("CastTimer")

func start_attack():
	casting = true

func end_attack():
	casting = false
