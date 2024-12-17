extends melee_weapon

class_name hammer

@export var charging_time: float
@export var reach: int

var strike_area
var shockwave_area

var strike_active = false
var shockwave_active = false

var charging = false
var charge_timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	strike_area = get_node("StrikeArea")
	strike_area.monitoring = false
	shockwave_area = get_node("ShockwaveArea")
	shockwave_area.monitoring = false
	charge_timer = get_node("ChargeTimer")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if attacking:
		if not charging: 
			charging = true
			charge_timer.start(charging_time)
		

func start_attack():
	attacking = true

func end_attack():
	attacking = false

func _on_charge_timer_timeout_do_attack():
	var to_mouse = position.direction_to(get_global_mouse_position())
	var damage_position = position + to_mouse * reach
	strike_area.position = damage_position
	shockwave_area.position = damage_position
	# need animation here
	
	charging = false
