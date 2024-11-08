extends CharacterBody2D

@export var damage: int
@export var speed: int
@export var projectile_health: int

var actual_damage: int
var direction: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	if projectile_health == 0:
		queue_free()
	var collision = move_and_collide(direction * speed * delta)
	if collision:
		projectile_health -= 1
