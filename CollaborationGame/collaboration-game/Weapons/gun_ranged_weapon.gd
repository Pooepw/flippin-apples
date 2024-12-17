extends ranged_weapon

class_name gun

# lower is faster
@export var fire_rate: int
@export var max_ammo: int
@export var gun_damage: int


# set by reload timer and physics process
var reloading = false
var reload_time

# shoot bullets when firing is true
var firing = false

var projectile_node
var current_ammo = 0
var fire_timer = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reload_time = get_node("ReloadTimer")
	projectile_node = load(projectile_scene)
	current_ammo = max_ammo

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if current_ammo == 0:
		reloading = true
		reload_time.start()
	if firing:
		fire_timer += 1
		if fire_timer % fire_rate == 0:
			fire()
	# include "animation" code i.e. the code that shows the weapon while firing

func _on_reload_timer_timeout() -> void:
	reloading = false
	current_ammo = max_ammo

func start_attack():
	if not reloading:
		firing = true

func end_attack():
	firing = false

func fire():
	current_ammo -= 1
	var projectile_instance = projectile_node.instantiate()
	projectile_instance.emitter = "player"
	# gdi godot
	projectile_instance.set_collision_layer_value(1, false)
	projectile_instance.set_collision_mask_value(1, false)
	projectile_instance.set_collision_layer_value(7, true)
	projectile_instance.set_collision_mask_value(3, true)
	projectile_instance.set_collision_mask_value(5, true)
	projectile_instance.set_collision_mask_value(6, true)
	projectile_instance.set_up_movement(get_global_mouse_position())
	projectile_instance.actual_damage = projectile_instance.damage
	ProjectileHandler.add_child(projectile_instance)
	projectile_instance.get_node("LiveTimer").start()
