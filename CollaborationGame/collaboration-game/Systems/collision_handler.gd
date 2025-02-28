extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# a function that handles collisions by applying damage to the collider
# mover is the object called move_and_collide while collision_instance is the 
# collision that results from the call
func handle_collision(mover, collision_instance: KinematicCollision2D):
	var collider = collision_instance.get_collider()
	print (collider)
	# cases for collision: 
	# player vs. contact enemy - only enemies have contact damage, but this 
	# check will still apply to ranged enemies; they will simply have 0 contact 
	# damage
	if mover is player and collider is mob:
		mover.current_hp -= collider.contact_damage
		mover.recently_damaged = true
		mover.invincibility_timer.start(mover.invincibility_time)
	# projectile vs. enemy - the projectile deals its damage and its knockback
	# to the enemy. calculably, this is the damage - enemy resistance and knockback
	# - enemy knockback resistance. also, the projectile loses one of its hits.
	if mover is projectile and collider is mob:
		pass
	# projectile vs projectile - 
	# if the projectiles are from different emitters, they should be able to harm 
	# each other. this means they should both lose one projectile health.
	if mover is projectile and collider is projectile:
		if mover.emitter == "player" and collider.emitter == "mob":
			mover.projectile_health -= 1
			collider.projectile_health -= 1
	# projectile vs room
	if mover is projectile and collider is TileMapLayer:
		mover.queue_free()
