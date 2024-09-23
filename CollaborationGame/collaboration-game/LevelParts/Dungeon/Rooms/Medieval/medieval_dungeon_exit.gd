extends Node2D

var exit_prompt

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	exit_prompt = get_node("Label")
	exit_prompt.visible = false 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if DungeonGenerator.display_exit_prompt:
		exit_prompt.visible = true


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is player:
		DungeonGenerator.display_exit_prompt = true
		
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is player:
		DungeonGenerator.display_exit_prompt = false
