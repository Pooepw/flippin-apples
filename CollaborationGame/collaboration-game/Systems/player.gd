extends CharacterBody2D

class_name player

# direction of the character's movement
var direction = Vector2(0, 0)

# character stats
var hp = 100
var current_hp = hp
var hp_regen = 0
var mana = 100
var current_mana = mana
var mana_regen = 1
var stamina = 100
var current_stamina = stamina
var stamina_regen = 2
var speed = 1000

var recently_damaged = false
var invincibility_timer
var invincibility_time = 0.1

# weapon stats
var equipped_weapon
var weapon_inventory_node
const default_weapon = "clear"

# booleans that help with making movement much smoother. 
var w_pressed = false
var s_pressed = false
var a_pressed = false
var d_pressed = false

# node access
var player_sprite
var player_interface

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_interface = get_node("PlayerInterface")
	weapon_inventory_node = player_interface.inventory_system
	player_sprite = get_node("Sprite")
	equipped_weapon = default_weapon
	invincibility_timer = get_node("InvincibilityFrames")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta) -> void:
	#if moving:
	
	move_and_collide(direction * speed * delta)
	# this may seem unintuitive, but if the player stops moving, the flip_h should
	# be retained
	if direction.x > 0:
		player_sprite.flip_h = true
		if equipped_weapon is not String:
			equipped_weapon.get_node("AttackStates").flip_h = true
	elif direction.x < 0:
		player_sprite.flip_h = false
		if equipped_weapon is not String:
			equipped_weapon.get_node("AttackStates").flip_h = false

func weapon_equipped():
	return not equipped_weapon is String

# new_weapon is the instance of the weapon
func equip_weapon(new_weapon):
	equipped_weapon = new_weapon
	add_child(new_weapon)
	player_interface.set_weapon_slot(new_weapon)
#
#func pickup_weapon(new_weapon):
	#if weapon_count < inventory_size:
		#var weapon_slot = 0
		#while weapon_inventory[weapon_slot] is weapon:
			#weapon_slot += 1
		#weapon_inventory[weapon_slot] = new_weapon
		#weapon_count += 1
	#else:
		#drop_weapon(current_slot)
		## need to create weapon drop code
		#equipped_weapon = new_weapon
#
#func drop_weapon(inventory_slot):
	#weapon_inventory[inventory_slot].place_weapon_on_floor()

# the player will gain invincibility from taking damage, then this will take it 
# away
func _on_invincibility_frames_timeout() -> void:
	recently_damaged = false
