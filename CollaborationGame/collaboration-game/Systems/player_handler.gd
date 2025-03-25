extends Node

var current_player

func _ready():
	pass

func set_up_player():
	var player_node = load("res://Systems/player.tscn")
	current_player = player_node.instantiate()
	current_player.position = Vector2(0,0)
	get_node("/root/TestNode/TownArea").add_child(current_player) #change later
