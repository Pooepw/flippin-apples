extends Node2D

enum power_status {ENABLED, DISABLED, NOT_OBTAINED}

var gross_state
var shape_state
var somebody_state
var you_state

func change_power_status(status, state):
	state = status
	
func _physics_process(delta: float) -> void:
	if gross_state == power_status.ENABLED:
		#player move 1.2x speed and 1.5x health
		pass
	if shape_state == power_status.ENABLED:
		#player stamina and mana 1.5x
		pass
	if somebody_state == power_status.ENABLED:
		#player damage 1.5x
		pass
	if you_state == power_status.ENABLED:
		#player divine shield active (write code for this)
		pass
