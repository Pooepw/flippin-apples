extends Node

var dialogue_on = false
var in_dialogue = false
var dialogue_node_access

var lines_to_add = []

var default_icon = load("res://Interfaces/UIAssets/DialogueInterface/default_character.png")

# please pass texture property
func change_npc_icon(sprite):
	dialogue_node_access.change_character(sprite)

func pass_lines(lines):
	dialogue_node_access.set_lines_of_dialogue(lines)

func clear_lines():
	dialogue_node_access.clear_lines()

func start_dialogue():
	pass_lines(lines_to_add)
	in_dialogue = true
	dialogue_node_access.visible = true

func end_dialogue():
	clear_lines()
	in_dialogue = false
	dialogue_on = false

func set_up_lines(lines):
	lines_to_add.append_array(lines)

func end_line():
	dialogue_node_access.end_line()
