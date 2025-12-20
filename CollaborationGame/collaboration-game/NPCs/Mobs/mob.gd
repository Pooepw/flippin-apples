extends Area2D

class_name mob

@export var health: int
@export var move_speed: int
@export var contact_damage: int

enum MOVE_MODES {BASIC, PROJECTOR, STILL_PROJECTOR, SPECIAL}
@export var move_mode: MOVE_MODES
@export var projector_closeness: int

@export var mob_type: MobGenerator.MOB_TYPES

var direction = Vector2(0,0)
var mob_spawner_parent = 0
var current_speed

func _ready() -> void:
	current_speed = move_speed
	set_up_collision()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if health <= 0:
		die()
	# in the future, the collision (from the move_and_collide function)
	# will be important for understanding player damage
	match move_mode:
		MOVE_MODES.BASIC:
			direction = global_position.direction_to(PlayerHandler.current_player.global_position)
			global_position += direction * current_speed * delta
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
	direction = global_position.direction_to(PlayerHandler.current_player.global_position)
	global_position += direction * current_speed * delta

func project():
	# written in projector mob but needed here too to be called
	pass

func die():
	if not mob_spawner_parent is int:
		mob_spawner_parent.mob_died()
	queue_free()

func set_up_collision():
	set_collision_layer_value(1, false)
	set_collision_layer_value(6, true)

func _on_body_entered(body: Node2D) -> void:
	if body is player:
		CollisionHandler.handle_collision(body, self)
