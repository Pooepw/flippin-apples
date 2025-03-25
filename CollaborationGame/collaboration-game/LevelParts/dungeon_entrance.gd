extends Node2D

var entry_text

func _ready() -> void:
	entry_text = get_node("EntryText")
	entry_text.visible = false

func _on_area_2d_body_entered_enter_dungeon(body: Node2D) -> void:
	if body is player:
		entry_text.visible = true
		DungeonGenerator.display_enter_prompt = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is player:
		entry_text.visible = false
		DungeonGenerator.display_enter_prompt = false
