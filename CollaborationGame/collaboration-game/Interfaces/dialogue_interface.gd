extends Control

const DEFAULT_TEXT_SPEED = 1
const FAST_TEXT_SPEED = 3
var text_speed = DEFAULT_TEXT_SPEED

var character_node
var text_node
var text_queue = []
var dialogue_passed = false

func _ready() -> void:
	character_node = get_node("Character")
	text_node = get_node("DialogueText")
	
	text_node.visible_ratio = 0

# if the dialogue interface is visible then the text should scroll
func _process(delta: float) -> void:
	if text_node.visible_ratio < 1 and visible:
		text_node.visible_ratio += 0.1 * text_speed

# please pass the character's texture image to this :::)))
func change_character(character_image):
	character_node.texture = character_image

# dialogue_lines should be the lines of text from the npc
func set_lines_of_dialogue(dialogue_lines):
	text_queue.append_array(dialogue_lines)

# plays the lines in text_queue in order
func play_lines():
	for line in text_queue:
		text_node.text = line
		text_node.visible_ratio = 0
		# this may make it hang
		while not dialogue_passed:
			pass
		dialogue_passed = false


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
