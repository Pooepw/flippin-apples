extends Control

const START_NODE = "res://LevelParts/Dungeon/Rooms/Medieval/medieval_starting_room_1.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	PlayerHandler.set_up_player()
	DungeonGenerator.generate_dungeon(START_NODE, 3)

func _on_quit_pressed() -> void:
	get_tree().quit()
