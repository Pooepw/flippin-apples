extends CharacterBody2D

class_name mob

var health = 0
var direction = Vector2(0,0)
var mob_spawner_parent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if health == 0:
		die()

func die():
	mob_spawner_parent.mob_count -= 1
	queue_free()
