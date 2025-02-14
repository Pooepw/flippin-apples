extends Node2D

var camera_node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera_node = get_node("Camera2D")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if DungeonGenerator.dungeon_loaded:
		camera_node.position = Vector2(DungeonGenerator.current_room.x * 
		DungeonGenerator.ROOM_SPACING, DungeonGenerator.current_room.y * 
		DungeonGenerator.ROOM_SPACING)
