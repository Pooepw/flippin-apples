extends Area2D

# a class for triggering the spawning/treasure/effect of a room

# access to room
var room_parent

# assign room parent to the variable
func _ready() -> void:
	room_parent = get_parent()

# calls the function of the parent to activate the aspect of the room
func activate_room():
	room_parent.activate_room_aspect()

# this class extends Area2D so this function takes advantage of that node's
# innate signals. only players should be taken to heart with this.
func _on_body_entered(body: Node2D) -> void:
	if body is player:
		get_node("Timer").start()

# just so the player does not get stuck or locked out of a room, wait a second
# before activation.
func _on_timer_timeout() -> void:
	activate_room()
