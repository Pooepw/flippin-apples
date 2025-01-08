extends magic_weapon

class_name staff

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	pass

func _on_cast_timer_timeout() -> void:
	pass
	# weapon do the big bang or smth
	# highly dependent on the animations
