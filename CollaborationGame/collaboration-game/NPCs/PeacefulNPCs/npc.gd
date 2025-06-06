extends Node2D

class_name npc

@export var lines: Array[String]
@export var is_default_npc: bool

var prompt
var character_icon

func _ready() -> void:
	prompt = get_node("DialoguePrompt")
	prompt.visible = false
	character_icon = get_node("DialogueIcon")

func _on_interaction_area_body_entered_activate_dialogue(body: Node2D) -> void:
	if body is player:
		print("dialogue near")
		prompt.visible = true
		NpcDialogueHandler.dialogue_on = true
		NpcDialogueHandler.set_up_lines(lines)
		if not is_default_npc:
			NpcDialogueHandler.change_npc_icon(character_icon.texture)


func _on_interaction_area_body_exited_deactivate_dialogue(body: Node2D) -> void:
	if body is player:
		prompt.visible = false
		NpcDialogueHandler.end_dialogue()
		if not is_default_npc:
			NpcDialogueHandler.change_npc_icon(NpcDialogueHandler.default_icon)
