extends charging_weapon

class_name staff_type

@export var mana_cost: int

func start_attack():
	if weapon_owner == OWNERS.PLAYER and PlayerHandler.current_player.current_mana >= mana_cost:
		super()
	elif weapon_owner == OWNERS.ENEMY:
		super()

func emit_attack():
	if weapon_owner == OWNERS.PLAYER:
		PlayerHandler.current_player.current_mana -= mana_cost
		PlayerHandler.current_player.start_regen_wait("Mana")
	do_attack()

func do_attack():
	pass
