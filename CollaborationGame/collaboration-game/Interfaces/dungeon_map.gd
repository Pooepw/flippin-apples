extends Control

const SPACING = 50
const DUNGEON_SIZE = 6

var node_array = []
var map_nodes

func _ready() -> void:
	node_array.append([])
	node_array.append([])
	node_array.append([])
	node_array.append([])
	node_array.append([])
	node_array.append([])
	for row in node_array:
		row.append(0)
		row.append(0)
		row.append(0)
		row.append(0)
		row.append(0)
		row.append(0)
	map_nodes = get_node("BaseMap/MapNodes")

func add_node(x, y, node):
	if node_array[x][y] == 0:
		var duplicate_node = node.duplicate()
		node_array[x][y] = duplicate_node
		map_nodes.add_child(duplicate_node)
		
func space_out_map():
	for row in DUNGEON_SIZE:
		for col in DUNGEON_SIZE:
			if not node_array[row][col] is int:
				node_array[row][col].position.x *= SPACING
				node_array[row][col].position.y *= SPACING
				
