extends Node

enum input_states {MOVE, UI}

var input_state = input_states.MOVE

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
						DungeonGenerator.clear_dungeon()
					if DungeonGenerator.display_enter_prompt:
						DungeonGenerator.generate_dungeon(
							("res://LevelParts/Dungeon/Rooms/Medieval/medieval_starting_room_1.tscn"), 3)
						
						
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
				1:
					if PlayerHandler.current_player.weapon_equipped():
						PlayerHandler.current_player.equipped_weapon.start_attack()
						print("fire")
				4:
					#insert weapon swapping (leftward)
					pass
				5:
					#insert weapon swapping (rightward)
					pass
		if not event.pressed:
			match event.button_index:
				1:
					if PlayerHandler.current_player.weapon_equipped():
						PlayerHandler.current_player.equipped_weapon.end_attack()
						print("stop fire")
				
			#if PlayerHandler.current_player.direction == Vector2(0, 0):
				#PlayerHandler.current_player.moving = false
