extends Control

var health_bar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_bar = get_node("HealthBar")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	health_bar.value = float(PlayerHandler.current_player.current_hp/PlayerHandler.current_player.hp) * 100
