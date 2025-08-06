extends weapon2

class_name sword_type

@export var projectile_reach: int

func start_attack():
	super()
	

func emit_attack():
	var emission_instance = weapon_emission.instantiate()
	emission_instance.project_wave(get_global_mouse_position(), projectile_reach, get_parent(), damage)
	
