extends ranged_weapon

class_name bow

@export var charge_time: int 
@export var projectile_force: int

var bow_ready = false
var charge = 0
var charging = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if charge < charge_time and charging: 
		charge += 1
	if not charge == 0 and not charging: 
		fire()
		
func fire():
	var bow_damage = projectile_force * (charge / charge_time)
