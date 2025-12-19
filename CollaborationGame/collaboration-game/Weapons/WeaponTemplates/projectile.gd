extends Area2D

class_name projectile

@export var damage: int
@export var speed: int
@export var projectile_health: int



var actual_damage: int
var direction: Vector2

var projectile_sprite
var emitter


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	projectile_sprite = get_node("ProjectileSprite")

func _physics_process(delta: float) -> void:
	if projectile_health == 0:
		queue_free()
	position += direction * speed * delta


func _on_live_timer_timeout() -> void:
	queue_free()

func set_up_movement(to_position):
	direction = position.direction_to(to_position)
	set_rotation(position.angle_to_point(to_position))

func fire_self(to_position, emitted_by, edited_damage: int = damage, edited_scale: float = 1.0, speed_edit: float = 1.0): 
	set_up_collision(emitted_by)
	position = emitted_by.global_position
	set_up_movement(to_position)
	actual_damage = edited_damage
	scale *= edited_scale
	speed *= speed_edit
	ProjectileHandler.add_child(self)
	get_node("LiveTimer").start()

# sets up whether emitted by player or mob
func set_up_collision(emitted_by):
	if emitted_by is player:
		emitter = CollisionHandler.EMITTER_TYPES.PLAYER
	else: 
		emitter = CollisionHandler.EMITTER_TYPES.MOB
	if emitter == CollisionHandler.EMITTER_TYPES.PLAYER:
		set_collision_layer_value(1, false)
		set_collision_mask_value(1, false)
		set_collision_layer_value(7, true)
		set_collision_mask_value(3, true)
		set_collision_mask_value(5, true)
		set_collision_mask_value(6, true)
	else:
		set_collision_layer_value(1, false)
		set_collision_mask_value(7, true)
		set_collision_mask_value(3, true)
		set_collision_layer_value(5, true)
		set_collision_layer_value(5, true)

# for walls
func _on_body_entered(body: Node2D):
	if body is mob:
		print ("enemy hit")
	CollisionHandler.handle_collision(self, body, actual_damage)

# for enemies
func _on_area_entered(area: Area2D) -> void:
	CollisionHandler.handle_collision(self, area, actual_damage)
