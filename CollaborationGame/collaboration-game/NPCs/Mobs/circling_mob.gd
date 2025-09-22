extends mob

class_name circling_mob

@export var direction_rotation_amount: float
var current_direction_rotation = 0

func _ready() -> void:
	super()
	direction = Vector2(1, 0)

func special_movement(delta):
	direction = direction.rotated(direction_rotation_amount)
	move_and_collide(direction * current_speed * delta)
	
