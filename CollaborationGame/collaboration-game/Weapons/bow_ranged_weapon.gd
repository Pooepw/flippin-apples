extends ranged_weapon

# one of the ranged weapon classes. actual bow weapons may use this or extend from
# it to establish special abilities.

# (to make this class extendable)
class_name bow

# these editor variables are to make making basic weapons easier.
# the projectile string is to be the path to the node of the projectile. 
# the charge time is the amount of time it takes to fully charge the bow.
# the bow damage is the amount of damage the bow adds to the projectile.
# the projectile speed is the amount of speed the projectile will be released 
# with. 
@export var charge_time: int 
@export var bow_damage: int
@export var projectile_speed: int

# projectile node is used to access the projectile node for instantiation.
# charge will grow until it reaches the charge time variable and dictate the 
# projectile's stats.
# charging is used to check if the bow should be charging up. this will be set
# by the input handler. 
var projectile_node
var charge = 0
var charging = false

# sets up the projectiles to be instantiated and flung
func _ready() -> void:
	super()
	projectile_node = load(projectile_scene)


# _physics_process is constantly being called. for bow, this has to be charging
# the bow over time until a certain point and then call fire when the bow
# is not charging. the current charge of the bow should be checked so the player
# is not constantly firing.
func _physics_process(delta: float) -> void:
	if charge < charge_time and charging: 
		charge += 1
	if not charge == 0 and not charging: 
		fire()
		charge = 0
		
# apply bow stats to the projectile by making an instance of the projectile and 
# applying the different stats of the bow to the projectile.
func fire():
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
	var edited_projectile_damage = bow_damage + projectile_instance.damage * (charge / charge_time)
	projectile_instance.actual_damage = edited_projectile_damage
	ProjectileHandler.add_child(projectile_instance)
	projectile_instance.get_node("LiveTimer").start()

func start_attack():
	print("charging")
	charging = true
	
func end_attack():
	print("firing")
	charging = false
