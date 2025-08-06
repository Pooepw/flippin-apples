extends weapon2

class_name charging_weapon

@export var uses_timer: bool
@export var charge_time: float

# to be played when charging hammer/bow/staff or reloading gun
var charging_sprite_frames

# if a weapon uses the timer (probably reloading a gun), then this will be set
var charging_timer

var charged = false

# sets up the special charging sprite
func _ready() -> void:
	super()
	charging_sprite_frames = weapon_sprites.sprite_frames
	if uses_timer: 
		charging_timer = get_node("ChargeTimer")

func handle_charge():
	var charge = 0

func begin_charge():
	weapon_sprites.play("Charging")

func start_attack():
	begin_charge()

func end_attack():
	weapon_sprites.play("Firing")
