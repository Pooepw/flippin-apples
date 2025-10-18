extends Node2D

class_name staff_attack

var emitter

func perform_attack(emitted_by, damage):
	# insert attack here
	pass

func set_up_hit_area():
	# will probably need this for things
	pass

func set_up_emitter(emitted_by):
	if emitted_by is player:
		emitter = CollisionHandler.EMITTER_TYPES.PLAYER
		position = get_global_mouse_position()
	else: 
		emitter = CollisionHandler.EMITTER_TYPES.MOB
		position = PlayerHandler.current_player.global_position
