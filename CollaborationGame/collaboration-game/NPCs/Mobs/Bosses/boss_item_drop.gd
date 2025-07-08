extends Node2D

enum power_status {ENABLED, DISABLED}

enum powers {GROSS, SHAPE, SOMEBODY, YOU}
	
func update_status(power, status) -> void:
	if status == power_status.ENABLED:
		match power:
			powers.GROSS:
				PlayerHandler.current_player.hp_mult_bonus = 1.5
				PlayerHandler.current_player.speed_mult_bonus = 1.2
			powers.SHAPE:
				PlayerHandler.current_player.mana_mult_bonus = 1.5
				PlayerHandler.current_player.stamina_mult_bonus = 1.5
			powers.SOMEBODY:
				PlayerHandler.current_player.damage_mult = 1.5
			powers.YOU:
				PlayerHandler.current_player.one_time_invincibility = true
	
	if status == power_status.DISABLED:
		match power:
			powers.GROSS:
				PlayerHandler.current_player.hp_mult_bonus = 1.0
				PlayerHandler.current_player.speed_mult_bonus = 1.0
			powers.SHAPE:
				PlayerHandler.current_player.mana_mult_bonus = 1.0
				PlayerHandler.current_player.stamina_mult_bonus = 1.0
			powers.SOMEBODY:
				PlayerHandler.current_player.damage_mult = 1.0
			powers.YOU:
				PlayerHandler.current_player.one_time_invincibility = false
