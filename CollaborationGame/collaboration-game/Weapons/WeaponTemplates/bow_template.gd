extends charging_weapon

class_name bow_type

@export var energy_cost: int

func start_attack():
	if weapon_owner == OWNERS.PLAYER:
		if PlayerHandler.current_player.current_stamina >= energy_cost:
			super()
	else:
		super()

func emit_attack():
	if weapon_owner == OWNERS.PLAYER:
		PlayerHandler.current_player.current_stamina -= energy_cost
		PlayerHandler.current_player.start_regen_wait("Stamina")
	var real_damage = (int)(damage * charge)
	var emission_instance = weapon_emission.instantiate()
	emission_instance.speed = (int)((float)(emission_instance.speed) * charge)
	var target_position
	if weapon_owner == OWNERS.PLAYER:
		target_position = get_global_mouse_position()
	else:
		target_position = PlayerHandler.current_player.global_position
	emission_instance.fire_self(target_position, get_parent(), real_damage)
