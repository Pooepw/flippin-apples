extends weapon2

class_name sword_type

@export var projectile_reach: int
@export var energy_cost: int

func _physics_process(delta: float) -> void:
	super(delta)
	if energy_cost > PlayerHandler.current_player.current_stamina:
		end_attack()

func start_attack():
	if weapon_owner == OWNERS.PLAYER and energy_cost <= PlayerHandler.current_player.current_stamina:
		super()
	elif weapon_owner == OWNERS.ENEMY:
		super()

func _on_weapon_sprites_animation_finished() -> void:
	super()
	if firing:
		weapon_sprites.play("Firing")

func emit_attack():
	if weapon_owner == OWNERS.PLAYER:
		PlayerHandler.current_player.current_stamina -= energy_cost
		PlayerHandler.current_player.start_regen_wait("Stamina")
	var emission_instance = weapon_emission.instantiate()
	var target_position
	if weapon_owner == OWNERS.PLAYER:
		target_position = get_global_mouse_position()
	else:
		target_position = PlayerHandler.current_player.global_position
	emission_instance.project_wave(target_position, projectile_reach, get_parent(), damage)
	
