extends Node2D

var projectile_count = 0
const max_projectiles = 255 # arbitrary unit for now


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if projectile_count == max_projectiles:
		print("should be deleting projectiles")
