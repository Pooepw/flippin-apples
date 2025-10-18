extends Node2D

class_name weapon2

# weapon name is the name of the weapon
# weapon emission_node is the "projectile" of the weapon. this can be an actual 
# projectile or a shockwave of some kind. the var itself is a node string to load.
@export var weapon_name: String
@export var weapon_emission_node: String
@export var damage: int

# state changes shown by firing and idle sprites. weapon icon is for UI.
var weapon_sprites
var weapon_icon

# ownership of weapon
enum OWNERS {PLAYER, ENEMY}
var weapon_owner
var weapon_owner_node

# weapon emission node to be instanced
var weapon_emission
var firing = false

# sets up the weapon sprites
func _ready() -> void:
	weapon_icon = get_node("WeaponIcon")
	weapon_icon.visible = true
	
	weapon_sprites = get_node("WeaponSprites")
	weapon_sprites.play("Idle")
	weapon_emission = load(weapon_emission_node)
	if get_parent() is player:
		weapon_owner = OWNERS.PLAYER
	else:
		weapon_owner = OWNERS.ENEMY
		weapon_owner_node = get_parent()

# flip the weapon's orientation depending on direction
func _physics_process(_delta: float) -> void:
	if weapon_owner == OWNERS.PLAYER:
		if PlayerHandler.current_player.direction.x < 0:
			weapon_sprites.flip_h = true
		if PlayerHandler.current_player.direction.x > 0:
			weapon_sprites.flip_h = false
	if weapon_owner == OWNERS.ENEMY:
		if weapon_owner_node.direction.x < 0:
			weapon_sprites.flip_h = true
		if weapon_owner_node.direction.x > 0:
			weapon_sprites.flip_h = false

func swap_sprite(to_sprite):
	weapon_sprites.play(to_sprite)

func emit_attack():
	pass

func _on_weapon_sprites_animation_finished() -> void:
	if weapon_sprites.animation == "Firing":
		emit_attack()

func start_attack():
	firing = true
	swap_sprite("Firing")

func end_attack():
	firing = false
	swap_sprite("Idle")
