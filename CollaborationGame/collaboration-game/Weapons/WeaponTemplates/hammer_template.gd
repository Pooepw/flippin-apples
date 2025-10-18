extends charging_weapon

class_name hammer_type

@export var energy_cost: int
@export var projectile_reach: int

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
	var target_position
	if weapon_owner == OWNERS.PLAYER:
		target_position = get_global_mouse_position()
	else:
		target_position = PlayerHandler.current_player.global_position
	emission_instance.project_wave(target_position, projectile_reach, get_parent(), charge, real_damage)
