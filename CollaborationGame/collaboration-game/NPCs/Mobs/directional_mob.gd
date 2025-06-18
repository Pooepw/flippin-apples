extends mob

class_name directional_mob

enum DIRECTIONS {NS, EW, NESW, NWSE}

@export var move_direction: DIRECTIONS
@export var move_time: float

var direction_timer

func _ready() -> void:
	direction_timer = get_node("DirectionTimer")
	match move_direction:
		DIRECTIONS.NS:
			direction = Vector2(0,1)
		DIRECTIONS.EW:
			direction = Vector2(1,0)
		DIRECTIONS.NESW:
			direction = Vector2(-1,1)
		DIRECTIONS.NWSE:
			direction = Vector2(1,1)
	direction_timer.start(move_time)

func special_movement(delta):
	move_and_collide(direction * delta * move_speed)


func _on_direction_timer_timeout() -> void:
	direction *= -1
	direction_timer.start(move_time)
