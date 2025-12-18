extends Control

var health_bar
var stamina_bar
var mana_bar
var player_node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_bar = get_node("HealthBar")
	stamina_bar = get_node("StaminaBar")
	mana_bar = get_node("ManaBar")
	player_node = PlayerHandler.current_player


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	health_bar.value = (float(player_node.current_hp)/float(player_node.hp)) * 100
	stamina_bar.value = (float(player_node.current_stamina)/float(player_node.stamina)) * 100
	mana_bar.value = (float(player_node.current_mana)/float(player_node.mana)) * 100
	
