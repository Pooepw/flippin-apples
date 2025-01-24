extends melee_weapon

class_name hammer

@export var charging_time: float
@export var cooldown_time: float
@export var reach: int

var strike_area
var shockwave_area
var attack_states

var strike_active = false
var shockwave_active = false

var charging = false
var can_charge = true
var charge_timer
var cooldown_timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	strike_area = get_node("StrikeArea")
	strike_area.monitoring = false
	shockwave_area = get_node("ShockwaveArea")
	shockwave_area.monitoring = false
	charge_timer = get_node("ChargeTimer")
	attack_states = get_node("AttackStates")
	cooldown_timer = get_node("CooldownTimer")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if attacking:
		if not charging and can_charge: 
			charging = true
			charge_timer.start(charging_time)
			attack_states.frame = 1

func start_attack():
	attacking = true

func end_attack():
	attacking = false
	if charging:
		charging = false
		attack_states.frame = 0

func _on_charge_timer_timeout_do_attack():
	attack_states.frame = 2
	var to_mouse = position.direction_to(get_global_mouse_position())
	var damage_position = position + to_mouse * reach
	strike_area.position = damage_position
	shockwave_area.position = damage_position
	
	cooldown_timer.start(cooldown_time)

func _on_cooldown_timer_timeout() -> void:
	can_charge = true
	charging = false
	if attacking:
		attack_states.frame = 1
