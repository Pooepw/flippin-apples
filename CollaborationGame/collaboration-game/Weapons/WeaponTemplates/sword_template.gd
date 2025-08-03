extends weapon2

class_name sword_type

func start_attack():
	super()
	

func _on_weapon_sprites_animation_finished() -> void:
	if weapon_sprites.animation == "Firing":
		emit_attack()

func emit_attack():
	super()
	
