extends CharacterBody2D

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
	var collision = move_and_collide(direction * speed * delta)
	if collision:
		CollisionHandler.handle_collision(self, collision)


func _on_live_timer_timeout() -> void:
	queue_free()

func set_up_movement(to_position):
	position = PlayerHandler.current_player.global_position
	direction = position.direction_to(to_position)
	set_rotation(position.angle_to_point(to_position))

func fire_self(to_position, emitted_by, edited_damage: int = damage): 
	set_up_movement(to_position)
	emitter = emitted_by
	# gdi godot
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)
	set_collision_layer_value(7, true)
	set_collision_mask_value(3, true)
	set_collision_mask_value(5, true)
	set_collision_mask_value(6, true)
	actual_damage = edited_damage
	ProjectileHandler.add_child(self)
	get_node("LiveTimer").start()
