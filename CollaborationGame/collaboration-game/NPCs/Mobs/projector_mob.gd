extends mob

class_name projector_mob

# projectile things
@export var projectile_string: String
@export var fire_time: float
var projectile_node
var fire_timer_node

var vision_range_node
var player_in_range

func _ready():
	projectile_node = load(projectile_string)
	vision_range_node = get_node("VisionRange")
	fire_timer_node = get_node("FireTimer")

func project():
	var projectile_instance = projectile_node.instantiate()
	projectile_instance.direction = PlayerHandler.current_player.global_position.direction_to(get_global_mouse_position())
	projectile_instance.actual_damage = self.damage
	ProjectileHandler.add_child(projectile_instance)



func _on_vision_range_body_entered(body: Node2D) -> void:
	if body is player:
		player_in_range = true


func _on_vision_range_body_exited(body: Node2D) -> void:
	if body is player:
		player_in_range = false
