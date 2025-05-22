extends weapon

class_name ranged_weapon

# projectile node access to cast over and over again
@export var projectile_scene: String
var projectile_node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	projectile_node = load(projectile_scene)

func fire():
	pass
