extends weapon

@export var uses_timer: bool
@export var charge_time: float

# to be played when charging hammer/bow/staff or reloading gun
var charging_sprite

# if a weapon uses the timer (probably reloading a gun), then this will be set
var charging_timer



func _ready() -> void:
	super()
	charging_sprite = get_node("ChargingSprite")
	if uses_timer: 
		charging_timer = get_node("ChargeTimer")

func analyze_charge_state():
	match typeof(self):
		hammer:
			pass
		bow:
			pass
		staff:
			pass
		gun:
			pass
