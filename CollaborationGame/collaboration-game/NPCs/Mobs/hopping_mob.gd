extends mob

class_name hopping_mob

@export var ordinary_move_speed: int

var hop_timer
var stop_timer

func _ready() -> void:
	hop_timer = get_node("HopTimer")
	stop_timer = get_node("StopTimer")
	print("readied")

func special_movement(delta):
	if stop_timer.is_stopped() and hop_timer.is_stopped():
		print("starting")
		stop_timer.start(1)
	move_and_collide(direction * delta * move_speed)


func _on_hop_timer_timeout() -> void:
	direction = global_position.direction_to(PlayerHandler.current_player.global_position)
	print("start hop")
	move_speed = ordinary_move_speed
	stop_timer.start(1)

func _on_stop_timer_timeout() -> void:
	print("start stop")
	move_speed = 0
	hop_timer.start(3)
