extends CharacterBody2D

class_name mob

@export var health: int
@export var move_speed: int
var direction = Vector2(0,0)
var mob_spawner_parent

enum MOVE_MODES {BASIC, PROJECTOR, SPECIAL}
@export var move_modes: MOVE_MODES

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if health == 0:
		die()
	# in the future, the collision will be important for understanding player damage
	move_and_collide(global_position.direction_to(Player.global_position) * delta * move_speed)



func die():
	mob_spawner_parent.mob_count -= 1
	queue_free()
