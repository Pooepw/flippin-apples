extends CharacterBody2D

class_name mob

@export var health: int
@export var move_speed: int
@export var contact_damage: int

enum MOVE_MODES {BASIC, PROJECTOR, STILL_PROJECTOR, SPECIAL}
@export var move_mode: MOVE_MODES
@export var projector_closeness: int

var direction = Vector2(0,0)
var mob_spawner_parent = 0
var current_speed

func _ready() -> void:
	current_speed = move_speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if health <= 0:
		die()
	# in the future, the collision (from the move_and_collide function)
	# will be important for understanding player damage
	match move_mode:
		MOVE_MODES.BASIC:
			direction = global_position.direction_to(PlayerHandler.current_player.global_position)
			move_and_collide(direction * delta * current_speed)
		MOVE_MODES.PROJECTOR:
			#direction = global_position.direction_to(PlayerHandler.current_player.global_position)
			#if global_position.distance_to(PlayerHandler.current_player.global_position) > projector_closeness:
				#move_and_collide(direction * delta * move_speed)
			#else:
				#pass
			pass
		MOVE_MODES.STILL_PROJECTOR:
			pass
		MOVE_MODES.SPECIAL:
			special_movement(delta)

func special_movement(delta):
	# overwrite this function in a new mob class that uses mob as a base.
	move_and_collide(global_position.direction_to(PlayerHandler.current_player.global_position) * delta * current_speed)

func project():
	# written in projector mob but needed here too to be called
	pass

func die():
	if not mob_spawner_parent is int:
		mob_spawner_parent.mob_count -= 1
	queue_free()
