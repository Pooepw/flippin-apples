extends Node2D

enum EMITTER_TYPES {PLAYER, MOB}
enum COLLIDER_TYPES {PLAYER, MOB, TILEMAP}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# a function that handles collisions by applying damage to the collider
# mover is the object called move_and_collide while collision_instance is the 
# collision that results from the call
func handle_collision(mover, collider, special_damage: int = 0):
	# cases for collision: 
	# player vs. contact enemy - only enemies have contact damage, but this 
	# check will still apply to ranged enemies; they will simply have 0 contact 
	# damage
	if mover is player and collider is mob:
		if special_damage == 0:
			mover.current_hp -= collider.contact_damage
		else:
			mover.current_hp -= special_damage
		mover.handle_damage()
	# projectile vs. enemy - the projectile deals its damage and its knockback
	# to the enemy. calculably, this is the damage - enemy resistance and knockback
	# - enemy knockback resistance. also, the projectile loses one of its hits.
	elif mover is projectile:
		if special_damage == 0:
			inflict_damage(collider, mover.damage)
		else:
			inflict_damage(collider, special_damage)
		mover.projectile_health -= 1
	elif mover is staff_attack and (collider is mob or collider is player):
		if special_damage == 0:
			inflict_damage(collider, mover.damage)
		else:
			inflict_damage(collider, special_damage)
	# projectile vs projectile - 
	# if the projectiles are from different emitters, they should be able to harm 
	# each other. this means they should both lose one projectile health.
	elif mover is projectile and collider is projectile:
		if mover.emitter == EMITTER_TYPES.PLAYER and collider.emitter == EMITTER_TYPES.MOB:
			mover.projectile_health -= 1
			collider.projectile_health -= 1
	# projectile vs room
	elif mover is projectile and collider is TileMapLayer:
		mover.queue_free()

func inflict_damage(collider, damage):
	if collider is player:
		collider.current_hp -= damage
	if collider is mob:
		collider.health -= damage

func handle_melee_strike(melee_area, collider, damage):
	if (melee_area.emitter == EMITTER_TYPES.PLAYER and collider is mob):
		collider.health -= damage
	if (melee_area.emitter == EMITTER_TYPES.MOB and collider is player):
		PlayerHandler.current_player.current_hp -= damage
