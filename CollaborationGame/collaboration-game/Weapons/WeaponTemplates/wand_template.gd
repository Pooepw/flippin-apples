extends weapon2

class_name wand_type

@export var mana_cost: int

func _physics_process(delta: float) -> void:
	super(delta)
	if weapon_owner == OWNERS.PLAYER:
		if mana_cost > PlayerHandler.current_player.current_mana:
			end_attack()

func start_attack():
	if weapon_owner == OWNERS.PLAYER and mana_cost < PlayerHandler.current_player.current_mana:
		PlayerHandler.current_player.current_mana -= mana_cost
		print(PlayerHandler.current_player.current_mana)
		PlayerHandler.current_player.start_regen_wait("Mana")
		super()
	elif weapon_owner == OWNERS.ENEMY:
		super()
	


func _on_weapon_sprite_animation_end():
	print(weapon_sprites.get_animation())
	if weapon_sprites.get_animation() == "Firing":
		print("firing")
		emit_attack()
		if firing:
			weapon_sprites.play("Firing")

func emit_attack():
	var emission_instance = weapon_emission.instantiate()
	var target_location
	if weapon_owner == OWNERS.PLAYER:
		target_location = get_global_mouse_position()
	else: 
		target_location = PlayerHandler.current_player.global_position
	emission_instance.fire_self(target_location, get_parent(), damage)
