extends melee_weapon

class_name hammer

@export var charging_time: float
@export var cooldown_time: float
@export var reach: int
@export var hammer_damage_node: String


var charging: bool = false
var can_charge: bool = true
var charge_timer
var cooldown_timer

var hammer_projection

var attack_ready: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	charge_timer = get_node("ChargeTimer")
	attack_states = get_node("AttackStates")
	cooldown_timer = get_node("CooldownTimer")
	hammer_projection = load(hammer_damage_node)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	super(delta)
	if attacking:
		if can_charge: 
			charging = true
			if charge_timer.is_stopped():
				charge_timer.start(charging_time)
			attack_states.frame = 1
			

func start_attack():
	attacking = true

func end_attack():
	#attacking = false
	if attack_ready:
		attack_ready = false
		do_attack()
		


func _on_charge_timer_timeout_do_attack():
	print ("charged")
	can_charge = false
	charging = false
	attack_states.frame = 2
	attack_ready = true

func do_attack():
	var new_wave = hammer_projection.instantiate()
	if get_parent() is player:
		new_wave.project_wave(get_global_mouse_position(), reach, PlayerHandler.current_player, damage)
	else:
		new_wave.project_wave(get_global_mouse_position(), reach, get_parent(), damage)
	can_charge = false
	cooldown_timer.start(cooldown_time)
	attack_states.frame = 0
	attacking = false

func _on_cooldown_timer_timeout() -> void:
	can_charge = true
