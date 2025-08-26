extends weapon2

class_name sword_type

@export var projectile_reach: int
@export var energy_cost: int

func emit_attack():
	PlayerHandler.current_player.current_stamina -= energy_cost
	var emission_instance = weapon_emission.instantiate()
	emission_instance.project_wave(get_global_mouse_position(), projectile_reach, get_parent(), damage)
	
