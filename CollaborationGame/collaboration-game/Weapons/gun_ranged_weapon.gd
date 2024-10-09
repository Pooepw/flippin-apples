extends ranged_weapon

class_name gun

# lower is faster
@export var fire_rate: int
@export var max_ammo: int


# set by reload timer and physics process
var reloading = false
var reload_time
# 
var firing = false

var current_ammo = 0
var fire_timer = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reload_time = get_node("ReloadTimer")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if current_ammo == 0:
		reloading = true
		reload_time.start()
	if firing:
		if fire_timer % fire_rate == 0:
			fire()

func _on_reload_timer_timeout() -> void:
	reloading = false
	current_ammo = max_ammo

func handle_attack():
	if not reloading:
		firing = true

func stop_attack():
	firing = false

func fire():
	current_ammo -= 1
