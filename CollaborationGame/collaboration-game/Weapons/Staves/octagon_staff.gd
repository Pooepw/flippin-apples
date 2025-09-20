extends staff_type


func do_attack():
	var emission_instance_1 = weapon_emission.instantiate()
	emission_instance_1.perform_single_attack(get_parent(), damage, Vector2(0, 1))
	var emission_instance_2 = weapon_emission.instantiate()
	emission_instance_2.perform_single_attack(get_parent(), damage, Vector2(1, 1))
	var emission_instance_3 = weapon_emission.instantiate()
	emission_instance_3.perform_single_attack(get_parent(), damage, Vector2(1, 0))
	var emission_instance_4 = weapon_emission.instantiate()
	emission_instance_4.perform_single_attack(get_parent(), damage, Vector2(1, -1))
	var emission_instance_5 = weapon_emission.instantiate()
	emission_instance_5.perform_single_attack(get_parent(), damage, Vector2(0, -1))
	var emission_instance_6 = weapon_emission.instantiate()
	emission_instance_6.perform_single_attack(get_parent(), damage, Vector2(-1, -1))
	var emission_instance_7 = weapon_emission.instantiate()
	emission_instance_7.perform_single_attack(get_parent(), damage, Vector2(-1, 0))
	var emission_instance_8 = weapon_emission.instantiate()
	emission_instance_8.perform_single_attack(get_parent(), damage, Vector2(-1, 1))
	
