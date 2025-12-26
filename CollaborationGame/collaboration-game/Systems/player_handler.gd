extends Node

var current_player
var player_set_up = false

func _ready():
	pass

func set_up_player():
	var player_node = load("res://Systems/player.tscn")
	current_player = player_node.instantiate()
	current_player.position = Vector2(0,0)
	get_node("/root/MainScene").add_child(current_player) #change later
	current_player.weapon_inventory_node.add_to_inventory("res://Weapons/Guns/aug.tscn")
	player_set_up = true

func _process(delta: float) -> void:
	if player_set_up and current_player.current_hp <= 0:
		end_game()

func end_game():
	player_set_up = false
	DungeonGenerator.clear_dungeon()
	current_player.queue_free()
