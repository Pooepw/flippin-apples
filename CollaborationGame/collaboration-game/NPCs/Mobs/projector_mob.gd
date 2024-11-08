extends mob

# projectile things
@export var projectile_string: String
var projectile_node

func _ready():
	projectile_node = load(projectile_string)

func project():
	var projectile_instance = projectile_node.instantiate()
	projectile_instance.direction = Player.global_position.direction_to(get_global_mouse_position())
	projectile_instance.actual_damage = self.damage
	Player.add_child(projectile_instance)
