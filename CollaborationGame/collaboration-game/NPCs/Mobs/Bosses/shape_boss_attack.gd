extends Node2D

var fire_timer
var wait_timer


const SHOOT_TIME = 0.1

var firing = false

var shape_beam = preload("res://NPCs/Mobs/Bosses/shape_laser.tscn")

func _ready():
	fire_timer = get_node("FireTimer")

func _on_fire_timer_timeout() -> void:
	if firing:
		fire_timer.start(SHOOT_TIME)
		fire_beam()

func start_firing():
	firing = true
	fire_timer.start(SHOOT_TIME)

func fire_beam():
	var new_beam = shape_beam.instantiate()
	var to_position = PlayerHandler.current_player.global_position
	new_beam.fire_self(to_position, get_parent().base_mob)
	#new_beam.global_position = global_position
	#new_beam.direction = position.direction_to(to_position)
	#new_beam.set_rotation(position.angle_to_point(to_position))
