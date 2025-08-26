extends weapon2

class_name charging_weapon

# to be played when charging hammer/bow/staff or reloading gun
var charging_sprite_frames

var charged = false
var charge_frames = 0
var charge = 0

# sets up the special charging sprite
func _ready() -> void:
	super()
	charging_sprite_frames = weapon_sprites.sprite_frames
	charge_frames = charging_sprite_frames.get_frame_count("Charging")

func _physics_process(delta: float) -> void:
	super(delta)
	if weapon_sprites.animation == "Charging":
		charge = (float)(weapon_sprites.frame + 1)/(float)(charge_frames)

func begin_charge():
	weapon_sprites.play("Charging")

func start_attack():
	if weapon_sprites.animation == "Idle":
		begin_charge()

func end_attack():
	if weapon_sprites.animation == "Charging":
		emit_attack()
		weapon_sprites.play("Firing")
	

func _on_weapon_sprites_animation_finished() -> void:
	if weapon_sprites.animation == "Firing":
		weapon_sprites.play("Idle")
	
