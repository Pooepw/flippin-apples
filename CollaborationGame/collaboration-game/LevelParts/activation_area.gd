extends Area2D

var room_parent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	room_parent = get_parent()


func activate_room():
	room_parent.activate_room_aspect()


func _on_body_entered(body: Node2D) -> void:
	if body is player:
		get_node("Timer").start()


func _on_timer_timeout() -> void:
	activate_room()
