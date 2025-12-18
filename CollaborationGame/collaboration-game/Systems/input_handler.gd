extends Node

enum input_states {MOVE, UI}

var input_state = input_states.MOVE

var player_inventory
var loot_available = false
var loot_string
var current_loot_pedestal

func set_up_inventory_control() -> void:
	player_inventory = PlayerHandler.current_player.get_node("PlayerInterface").get_node("InventorySystem")

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed:
			match event.keycode:
				KEY_A:
					PlayerHandler.current_player.direction.x = -1
					PlayerHandler.current_player.a_pressed = true
				KEY_W:
					PlayerHandler.current_player.direction.y = -1
					PlayerHandler.current_player.w_pressed = true
				KEY_S:
					PlayerHandler.current_player.direction.y = 1
					PlayerHandler.current_player.s_pressed = true
				KEY_D:
					PlayerHandler.current_player.direction.x = 1
					PlayerHandler.current_player.d_pressed = true
				KEY_Z:
					if DungeonGenerator.display_exit_prompt:
						end_dungeon_level()
					if DungeonGenerator.display_enter_prompt:
						DungeonGenerator.generate_dungeon(
							("res://LevelParts/Dungeon/Rooms/Medieval/medieval_starting_room_1.tscn"), 3)
					if NpcDialogueHandler.dialogue_on and not NpcDialogueHandler.in_dialogue:
						NpcDialogueHandler.start_dialogue()
					elif NpcDialogueHandler.in_dialogue:
						NpcDialogueHandler.end_line()
					if loot_available:
						player_inventory.add_to_inventory(loot_string)
						current_loot_pedestal.queue_free()
				KEY_1:
					player_inventory.swap_weapon(0)
				KEY_2:
					player_inventory.swap_weapon(1)
				KEY_3:
					player_inventory.swap_weapon(2)
						
		if not event.pressed:
			match event.keycode:
				KEY_A:
					PlayerHandler.current_player.direction.x = 0 if not PlayerHandler.current_player.d_pressed else 1
					PlayerHandler.current_player.a_pressed = false
				KEY_W:
					PlayerHandler.current_player.direction.y = 0 if not PlayerHandler.current_player.s_pressed else 1
					PlayerHandler.current_player.w_pressed = false
				KEY_S:
					PlayerHandler.current_player.direction.y = 0 if not PlayerHandler.current_player.w_pressed else -1
					PlayerHandler.current_player.s_pressed = false
				KEY_D:
					PlayerHandler.current_player.direction.x = 0 if not PlayerHandler.current_player.a_pressed else -1
					PlayerHandler.current_player.d_pressed = false
				
	if event is InputEventMouseButton:
		if event.pressed:
			match event.button_index:
				2:
					if PlayerHandler.current_player.weapon_equipped():
						PlayerHandler.current_player.equipped_weapon.start_attack()
						print("fire")
				4:
					var to_slot = player_inventory.slot_number - 1 if player_inventory.slot_number - 1 >= 0 else 2
					player_inventory.swap_weapon(to_slot)
				5:
					var to_slot = player_inventory.slot_number + 1 if player_inventory.slot_number + 1 <= 2 else 0
					player_inventory.swap_weapon(to_slot)
		if not event.pressed:
			match event.button_index:
				2:
					if PlayerHandler.current_player.weapon_equipped():
						PlayerHandler.current_player.equipped_weapon.end_attack()
						print("stop fire")

func end_dungeon_level():
	# needs handling of going to next level
	DungeonGenerator.clear_dungeon()
