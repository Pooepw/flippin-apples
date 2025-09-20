extends charging_weapon

class_name staff_type

@export var mana_cost: int

func start_attack():
	if PlayerHandler.current_player.current_mana >= mana_cost:
		super()

func emit_attack():
	PlayerHandler.current_player.current_mana -= mana_cost
	PlayerHandler.current_player.start_regen_wait("Mana")
	do_attack()

func do_attack():
	pass
