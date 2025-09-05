extends weapon2

class_name sword_type

@export var projectile_reach: int
@export var energy_cost: int

func _physics_process(delta: float) -> void:
	super(delta)
	if energy_cost > PlayerHandler.current_player.current_stamina:
		end_attack()

func start_attack():
	if energy_cost <= PlayerHandler.current_player.current_stamina:
		super()

func _on_weapon_sprites_animation_finished() -> void:
	super()
	if firing:
		weapon_sprites.play("Firing")

func emit_attack():
	PlayerHandler.current_player.current_stamina -= energy_cost
	PlayerHandler.current_player.start_regen_wait("Stamina")
	var emission_instance = weapon_emission.instantiate()
	emission_instance.project_wave(get_global_mouse_position(), projectile_reach, get_parent(), damage)
	
