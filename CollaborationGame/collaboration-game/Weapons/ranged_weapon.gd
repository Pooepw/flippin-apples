extends weapon

class_name ranged_weapon

# projectile node access to cast over and over again
@export var projectile_scene: String
var projectile

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	projectile = load(projectile_scene)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
