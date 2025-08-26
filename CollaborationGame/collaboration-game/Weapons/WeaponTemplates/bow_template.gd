extends charging_weapon

class_name bow_type

@export var energy_cost: int

func start_attack():
	if energy_cost <= PlayerHandler.current_player.current_stamina:
		super()

func emit_attack():
	PlayerHandler.current_player.current_stamina -= energy_cost
	PlayerHandler.current_player.start_regen_wait("Stamina")
	var real_damage = (int)(damage * charge)
	var emission_instance = weapon_emission.instantiate()
	emission_instance.speed = (int)((float)(emission_instance.speed) * charge)
	emission_instance.fire_self(get_global_mouse_position(), get_parent(), real_damage)
