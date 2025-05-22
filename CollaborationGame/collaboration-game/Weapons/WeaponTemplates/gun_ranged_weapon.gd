extends ranged_weapon

class_name gun

# lower is faster
@export var fire_rate: int
@export var max_ammo: int
@export var gun_damage: int
@export var reload_time: int


# set by reload timer and physics process
var reloading = false
var reload_timer

# shoot bullets when firing is true
var firing = false
var previously_firing = false

var projectile_node
var attack_states

var current_ammo = 0
var fire_timer = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	reload_timer = get_node("ReloadTimer")
	projectile_node = load(projectile_scene)
	attack_states = get_node("AttackStates")
	current_ammo = max_ammo

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if current_ammo == 0 and not reloading:
		reload()
	if firing:
		attack_states.frame = 1
		fire_timer += 1
		if fire_timer % fire_rate == 0:
			fire()
	elif not reloading:
		attack_states.frame = 0
	# include "animation" code i.e. the code that shows the weapon while firing

func reload():
	reloading = true
	if firing:
		previously_firing = true
	firing = false
	attack_states.frame = 2
	reload_timer.start(reload_time)

func _on_reload_timer_timeout() -> void:
	reloading = false
	if previously_firing:
		firing = true
	elif not firing:
		attack_states.frame = 0
	current_ammo = max_ammo

func start_attack():
	if not reloading:
		firing = true
		

func end_attack():
	firing = false
	previously_firing = false
	if not reloading:
		attack_states.frame = 0

func fire():
	current_ammo -= 1
	var projectile_instance = projectile_node.instantiate()
	projectile_instance.fire_self(get_global_mouse_position(), PlayerHandler.current_player)
