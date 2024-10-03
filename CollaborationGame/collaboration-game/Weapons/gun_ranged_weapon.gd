extends ranged_weapon

class_name gun_ranged_weapon

# lower is faster
@export var fire_rate: int
@export var ammo: int

# set by reload timer and physics process
var reloading = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	pass

func _on_reload_timer_timeout() -> void:
	reloading = true
