extends CharacterBody2D

class_name mob

var health = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if health == 0:
		MobGenerator.mob_count -= 1
		queue_free()
