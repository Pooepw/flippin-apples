extends charging_weapon

class_name gun_type

@export var mag_size: int

var current_bullets

func _ready():
	super()
	current_bullets = mag_size

func start_attack():
	firing = true
	if weapon_sprites.get_animation() == "Idle":
		weapon_sprites.play("Firing")

func end_attack():
	firing = false
	if weapon_sprites.get_animation() == "Firing":
		weapon_sprites.stop()
		weapon_sprites.play("Idle")
	if current_bullets == 0:
		weapon_sprites.play("Charging")

func reload():
	current_bullets = mag_size
	if firing:
		weapon_sprites.play("Firing")
	else:
		weapon_sprites.play("Idle")

func _on_weapon_animation_finished():
	if weapon_sprites.get_animation() == "Firing":
		print("firing")
		if current_bullets > 0:
			emit_attack()
			weapon_sprites.play("Firing")
		else:
			begin_charge()
	elif weapon_sprites.get_animation() == "Charging":
		reload()

func emit_attack():
	current_bullets -= 1
	var bullet_instance = weapon_emission.instantiate()
	bullet_instance.fire_self(get_global_mouse_position(), get_parent(), damage)
