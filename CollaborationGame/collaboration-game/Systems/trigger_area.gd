extends Area2D

var triggered_spawns = false
var open_doors = true


func _on_body_entered(body: Node2D) -> void:
	if body is player:
		get_node("Timer").start()


func _on_timer_timeout() -> void:
	open_doors = false
	triggered_spawns = true
