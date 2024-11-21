extends Control

# access nodes
var inventory_system

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	inventory_system = get_node("InventorySystem")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#size = Vector2(get_viewport_rect().size.x - 100, get_viewport_rect().size.y - 100)
	pass
