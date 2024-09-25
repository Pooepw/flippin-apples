extends CharacterBody2D

class_name player

# direction of the character's movement
var direction = Vector2(0, 0)

# this is here for testing for now
var speed = 2000

# booleans that help with making movement much smoother. 
var w_pressed = false
var s_pressed = false
var a_pressed = false
var d_pressed = false



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta) -> void:
	#if moving:
	move_and_collide(direction * speed * delta)

	
