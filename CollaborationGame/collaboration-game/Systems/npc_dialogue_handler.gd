extends Node

var dialogue_on = false
var dialogue_node_access

var default_icon = load("res://Interfaces/UIAssets/DialogueInterface/default_character.png")

# please pass texture property
func change_npc_icon(sprite):
	dialogue_node_access.change_character(sprite)

func pass_lines(lines):
	dialogue_node_access.set_lines_of_dialogue(lines)

func play_lines():
	dialogue_node_access.play_lines()

func clear_lines():
	dialogue_node_access.clear_lines()
