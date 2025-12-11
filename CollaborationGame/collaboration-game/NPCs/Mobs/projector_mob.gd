extends mob

class_name projector_mob

# projectile things
@export var projectile_string: String
@export var fire_time: float
@export var damage_edit: int
@export var scale_edit: float = 1.0
@export var projectile_speed_edit: float = 1.0

var projectile_node
var fire_timer_node

var vision_range_node
var player_in_range
var attacking_animation_node
var idle_node

func _ready():
	super()
	projectile_node = load(projectile_string)
	vision_range_node = get_node("VisionRange")
	fire_timer_node = get_node("FireTimer")
	attacking_animation_node = get_node("AttackingAnimation")
	idle_node = get_node("IdleSprite")
	attacking_animation_node.visible = false
	
func project():
	var projectile_instance = projectile_node.instantiate()
	var actual_damage = damage_edit if not damage_edit == 0 else projectile_instance.damage
	projectile_instance.fire_self(PlayerHandler.current_player.global_position, self, actual_damage, scale_edit)

func _physics_process(delta: float) -> void:
	super(delta)
	if player_in_range:
		activate_shooting()
	elif not player_in_range:
		move(delta)

func activate_shooting():
	if move_mode == MOVE_MODES.STILL_PROJECTOR:
		attacking_animation_node.visible = true
		idle_node.visible = false
	elif move_mode == MOVE_MODES.PROJECTOR:
		attacking_animation_node.visible = false
		idle_node.visible = true
		direction = Vector2(0,0)

func move(delta):
	if move_mode == MOVE_MODES.STILL_PROJECTOR:
		idle_node.visible = true
		attacking_animation_node.visible = false
	elif move_mode == MOVE_MODES.PROJECTOR:
		attacking_animation_node.visible = true
		idle_node.visible = false
		direction = global_position.direction_to(PlayerHandler.current_player.global_position)
		global_position += direction * current_speed * delta

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
