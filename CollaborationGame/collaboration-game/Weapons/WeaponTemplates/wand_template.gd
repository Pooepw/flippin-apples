extends weapon2

class_name wand_type

@export var mana_cost: int

func _physics_process(delta: float) -> void:
	super(delta)
	if mana_cost > PlayerHandler.current_player.current_mana:
		end_attack()

func start_attack():
	if mana_cost < PlayerHandler.current_player.current_mana:
		super()


func _on_weapon_sprite_animation_end():
	print(weapon_sprites.get_animation())
	if weapon_sprites.get_animation() == "Firing":
		print("firing")
		emit_attack()
		if firing:
			weapon_sprites.play("Firing")

func emit_attack():
	PlayerHandler.current_player.current_mana -= mana_cost
	print(PlayerHandler.current_player.current_mana)
	PlayerHandler.current_player.start_regen_wait("Mana")
	var emission_instance = weapon_emission.instantiate()
	emission_instance.fire_self(get_global_mouse_position(), get_parent(), damage)
