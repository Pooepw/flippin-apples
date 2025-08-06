extends CharacterBody2D

class_name player

# direction of the character's movement
var direction = Vector2(0, 0)

# character stats
var hp = 100
var current_hp = hp
var can_regen_health = true
var hp_mult_bonus = 1.0
var hp_regen = 0
var hp_regen_timer

var mana = 100
var current_mana = mana
var can_regen_mana = true
var mana_mult_bonus = 1.0
var mana_regen = 0.3
var mana_regen_timer

var stamina = 100
var current_stamina = stamina
var can_regen_stamina = true
var stamina_mult_bonus = 1.0
var stamina_regen = 2
var stam_regen_timer

var speed = 1000
var speed_mult = 1.0

var recently_damaged = false
var invincibility_timer
var invincibility_time = 0.1
var one_time_invincibility_active = false

# weapon stats
var equipped_weapon
var weapon_inventory_node
const default_weapon = "clear"
var damage_mult = 1.0

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
	NpcDialogueHandler.dialogue_node_access = player_interface.dialogue_interface
	
	player_sprite = get_node("AnimatedSprite2D")
	equipped_weapon = default_weapon
	
	invincibility_timer = get_node("InvincibilityFrames")
	
	hp_regen_timer = get_node("HealthRegenTimer")
	mana_regen_timer = get_node("ManaRegenTimer")
	stam_regen_timer = get_node("StaminaRegenTimer")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta) -> void:
	#if moving:
	
	move_and_collide(direction * speed * delta)
	if not direction == Vector2(0,0):
		player_sprite.play()
	else:
		player_sprite.stop()
	if direction.x > 0:
		player_sprite.set_animation("RightFacing")
		#if equipped_weapon is not String:
			#equipped_weapon.get_node("AttackStates").flip_h = true
	elif direction.x < 0:
		player_sprite.set_animation("LeftFacing")
	regenerate_resources()

# called every frame to regenerate the player's resources of hp, mana and stamina
func regenerate_resources():
	if can_regen_health:
		if current_hp < hp:
			var new_hp = current_hp + hp_regen
			current_hp = new_hp if new_hp < hp else hp
	if can_regen_mana:
		if current_mana < mana:
			var new_mana = current_mana + mana_regen
			current_mana = new_mana if new_mana < mana else mana
			print (current_mana)
	if can_regen_stamina:
		if current_stamina < stamina:
			var new_stamina = current_stamina + stamina_regen
			current_stamina = new_stamina if new_stamina < stamina else stamina

# starts the regen timer of choice; to be used by weapons or post invincibility
func start_regen_wait(timer: String):
	match timer:
		"Mana":
			can_regen_mana = false
			if mana_regen_timer.is_stopped():
				mana_regen_timer.start(2)
			else:
				mana_regen_timer.stop()
				mana_regen_timer.start(2)
		"Stamina":
			can_regen_stamina = false
			if stam_regen_timer.is_stopped():
				stam_regen_timer.start(5)
			else:
				stam_regen_timer.stop()
				stam_regen_timer.start(5)
		"Health":
			can_regen_health = false
			if hp_regen_timer.is_stopped():
				hp_regen_timer.start(5)
			else:
				hp_regen_timer.stop()
				hp_regen_timer.start(5)

# these three are called when the associated timer stops, enabling the resource
# to regenerate
func _can_regen_mana():
	can_regen_mana = true

func _can_regen_stamina():
	can_regen_stamina = true

func _can_regen_health():
	can_regen_health = true

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
