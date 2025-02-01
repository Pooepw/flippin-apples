extends mob

@export var ordinary_move_speed: int

var hop_timer

func _ready() -> void:
	hop_timer = get_node("HopTimer")
	

func _on_hop_timer_timeout() -> void:
	move_speed = 0 if not move_speed == 0 else ordinary_move_speed
	hop_timer.start(1)
