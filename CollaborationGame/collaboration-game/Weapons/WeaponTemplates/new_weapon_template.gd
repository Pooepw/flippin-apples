extends Node2D

class_name weapon2

# weapon name is the name of the weapon
# weapon emission_node is the "projectile" of the weapon. this can be an actual 
# projectile or a shockwave of some kind. the var itself is a node string to load.
@export var weapon_name: String
@export var weapon_emission_node: String

# state changes shown by firing and idle sprites. weapon icon is for UI.
var weapon_sprites
var weapon_icon

# weapon emission node to be instanced
var weapon_emission

# sets up the weapon sprites
func _ready() -> void:
	weapon_icon = get_node("WeaponIcon")
	weapon_icon.visible = true
	
	weapon_sprites = get_node("WeaponSprites")
	
	weapon_emission = load(weapon_emission_node)

# flip the weapon's orientation depending on direction
func _physics_process(delta: float) -> void:
	if PlayerHandler.current_player.direction.x < 0:
		weapon_sprites.flip_h = false
	if PlayerHandler.current_player.direction.x > 0:
		weapon_sprites.flip_h = true

func swap_sprite(to_sprite):
	weapon_sprites.play(to_sprite)

func emit_attack():
	var emission_instance = weapon_emission.instantiate()

func start_attack():
	swap_sprite("Firing")

func end_attack():
	swap_sprite("Idle")
