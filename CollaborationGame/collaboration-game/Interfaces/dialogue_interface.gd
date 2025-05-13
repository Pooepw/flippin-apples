extends Control

const DEFAULT_TEXT_SPEED = 1
const FAST_TEXT_SPEED = 3
var text_speed = DEFAULT_TEXT_SPEED

var character_node
var text_node
var current_text
var text_queue = []
var dialogue_passed = false

enum NPC_TYPE {BASIC, DIALOGUE, TRADING, SPECIAL_DIALOGUE}

var current_npc_type

signal end_dialogue_line

func _ready() -> void:
	character_node = get_node("Character")
	text_node = get_node("DialogueText")
	current_text = 0
	text_node.visible_ratio = 0

# if the dialogue interface is visible then the text should scroll
func _process(delta: float) -> void:
	if visible:
		if current_text is int:
			if not text_queue.is_empty():
				current_text = text_queue.pop_front()
				text_node.text = current_text
			else:
				visible = false
				clear_lines()
				NpcDialogueHandler.in_dialogue = false
		if text_node.visible_ratio < 1:
			text_node.visible_ratio += text_speed * delta
		
		

# please pass the character's texture image to this :::)))
func change_character(character_image):
	character_node.texture = character_image

# dialogue_lines should be the lines of text from the npc
func set_lines_of_dialogue(dialogue_lines):
	text_queue.append_array(dialogue_lines)
	print(text_queue)
	text_node.visible_ratio = 0
	print(text_node.visible_ratio)


func clear_lines():
	text_queue.clear()
	print(text_queue)
	current_text = 0
	text_node.text = ""

# changes the text speed to the ones listed above (may need to change fast speed)
func change_text_speed(fast_on):
	if not fast_on:
		text_speed = DEFAULT_TEXT_SPEED
	if fast_on:
		text_speed = FAST_TEXT_SPEED

func close_dialogue():
	visible = false

func skip_line():
	text_node.visible_ratio = 1

func end_line():
	end_dialogue_line.emit()

func _on_end_dialogue_line() -> void:
	if text_node.visible_ratio == 1:
		print("end line")
		current_text = 0
		text_node.visible_ratio = 0
	else: 
		text_node.visible_ratio = 1
