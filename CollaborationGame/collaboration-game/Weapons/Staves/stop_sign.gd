extends staff_type

func do_attack():
	var emission_instance = weapon_emission.instantiate()
	emission_instance.perform_attack(get_parent(), damage)
