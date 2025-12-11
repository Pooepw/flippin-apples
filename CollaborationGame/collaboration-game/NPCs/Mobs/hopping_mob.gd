extends mob

class_name hopping_mob

@export var ordinary_move_speed: int
@export var hop_time: int = 1
@export var stop_time: int = 1

var hop_timer
var stop_timer
var stopped = false

func _ready() -> void:
	super()
	hop_timer = get_node("HopTimer")
	stop_timer = get_node("StopTimer")
	print("readied")

func special_movement(delta):
	if stop_timer.is_stopped() and hop_timer.is_stopped():
		print("starting")
		stop_timer.start(hop_time)
	global_position += direction * delta * current_speed


func _on_hop_timer_timeout() -> void:
	direction = global_position.direction_to(PlayerHandler.current_player.global_position)
	print("start hop")
	current_speed = ordinary_move_speed
	stop_timer.start(hop_time)

func _on_stop_timer_timeout() -> void:
	print("start stop")
	current_speed = 0
	hop_timer.start(stop_time)
