extends CharacterBody2D

class_name mob

@export var health: int
@export var move_speed: int
@export var contact_damage: int

enum MOVE_MODES {BASIC, PROJECTOR, STILL_PROJECTOR, SPECIAL}
@export var move_mode: MOVE_MODES
@export var projector_closeness: int

var direction = Vector2(0,0)
var mob_spawner_parent

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if health == 0:
		die()
	# in the future, the collision (from the move_and_collide function)
	# will be important for understanding player damage
	match move_mode:
		MOVE_MODES.BASIC:
			move_and_collide(global_position.direction_to(Player.global_position) * delta * move_speed)
		MOVE_MODES.PROJECTOR:
			if global_position.distance_to(Player.global_position) > projector_closeness:
				move_and_collide(global_position.direction_to(Player.global_position) * delta * move_speed)
			else:
				#put in projection function later
				project()
		MOVE_MODES.STILL_PROJECTOR:
			# put in projection function later
			project()
		MOVE_MODES.SPECIAL:
			special_movement(delta)

func special_movement(delta):
	# overwrite this function in a new mob class that uses mob as a base.
	move_and_collide(global_position.direction_to(Player.global_position) * delta * move_speed)

func project():
	# written in projector mob but needed here too to be called
	pass

func die():
	mob_spawner_parent.mob_count -= 1
	queue_free()
