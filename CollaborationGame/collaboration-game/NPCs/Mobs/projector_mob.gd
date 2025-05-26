extends mob

class_name projector_mob

# projectile things
@export var projectile_string: String
@export var fire_time: float
var projectile_node
var fire_timer_node

var vision_range_node
var player_in_range
var attacking_animation_node
var idle_node

func _ready():
	projectile_node = load(projectile_string)
	vision_range_node = get_node("VisionRange")
	fire_timer_node = get_node("FireTimer")
	attacking_animation_node = get_node("AttackingAnimation")
	idle_node = get_node("IdleSprite")
	attacking_animation_node.visible = false
	
func project():
	var projectile_instance = projectile_node.instantiate()
	projectile_instance.fire_self(PlayerHandler.current_player.global_position, self)

func _physics_process(delta: float) -> void:
	super(delta)
	if player_in_range:
		if move_mode == MOVE_MODES.STILL_PROJECTOR:
			attacking_animation_node.visible = true
			idle_node.visible = false
		elif move_mode == MOVE_MODES.PROJECTOR:
			attacking_animation_node.visible = false
			idle_node.visible = true
			direction = Vector2(0,0)
	elif not player_in_range:
		if move_mode == MOVE_MODES.STILL_PROJECTOR:
			idle_node.visible = true
			attacking_animation_node.visible = false
		elif move_mode == MOVE_MODES.PROJECTOR:
			attacking_animation_node.visible = true
			idle_node.visible = false
			direction = global_position.direction_to(PlayerHandler.current_player.global_position)
			move_and_collide(direction * move_speed * delta)
	

func _on_vision_range_body_entered(body: Node2D) -> void:
	print ("player in range")
	if body is player:
		player_in_range = true
		fire_timer_node.start(fire_time)

func _on_vision_range_body_exited(body: Node2D) -> void:
	print ("player out of range")
	if body is player:
		player_in_range = false
		fire_timer_node.stop()

func _on_fire_timer_timeout() -> void:
	project()
	if player_in_range:
		fire_timer_node.start(fire_time)
