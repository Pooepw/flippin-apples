extends charging_weapon

class_name hammer_type

@export var energy_cost: int
@export var projectile_reach: int

func emit_attack():
	PlayerHandler.current_player.current_stamina -= energy_cost
	var real_damage = (int)(damage * charge)
	var emission_instance = weapon_emission.instantiate()
	emission_instance.project_wave(get_global_mouse_position(), projectile_reach, get_parent(), charge, real_damage)
