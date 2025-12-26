extends Node2D

var exit_prompt

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	exit_prompt = get_node("Label")
	exit_prompt.visible = false 

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is player:
		exit_prompt.visible = true
		DungeonGenerator.can_exit = true
		
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is player:
		exit_prompt.visible = false
		DungeonGenerator.can_exit = false
