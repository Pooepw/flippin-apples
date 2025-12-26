extends Control

const SPACING = 50
const DUNGEON_SIZE = 6
const BASE_POSITION = Vector2(3, 3)
const BASE_PLAYER_POSITION = Vector2(7, 7)

var node_array = []
var map_nodes
var player_icon
var player_location = Vector2(0,0)

func _ready() -> void:
	for n in DUNGEON_SIZE:
		node_array.append([])
	for row in node_array:
		for col in DUNGEON_SIZE:
			row.append(0)
	print(node_array)
	map_nodes = get_node("BaseMap")
	player_icon = get_node("BaseMap/PlayerIcon")

func _process(_delta: float) -> void:
	player_icon.position = BASE_PLAYER_POSITION + (player_location * SPACING)

func add_node(x, y, node):
	if node_array[x][y] is int:
		var duplicate_node = node.duplicate()
		node_array[x][y] = duplicate_node
		map_nodes.add_child(duplicate_node)
		node_array[x][y].position = BASE_PLAYER_POSITION + Vector2(y, x) * SPACING

func clear_map():
	node_array.clear()
	
