extends CharacterBody2D

@export var damage: int
@export var speed: int
@export var projectile_health: int

var actual_damage: int
var direction: Vector2

var projectile_sprite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	projectile_sprite = get_node("ProjectileSprite")


func _physics_process(delta: float) -> void:
	if projectile_health == 0:
		queue_free()
	var collision = move_and_collide(direction * speed * delta)
	if collision:
		projectile_health -= 1


func _on_live_timer_timeout() -> void:
	queue_free()

func set_up_movement(to_position):
	position = Player.global_position
	direction = position.direction_to(to_position)
	set_rotation(position.angle_to_point(to_position))
