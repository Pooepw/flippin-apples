extends Node

enum input_states {MOVE, UI}

var input_state = input_states.MOVE

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed:
			match event.keycode:
				KEY_A:
					Player.direction.x = -1
					Player.a_pressed = true
				KEY_W:
					Player.direction.y = -1
					Player.w_pressed = true
				KEY_S:
					Player.direction.y = 1
					Player.s_pressed = true
				KEY_D:
					Player.direction.x = 1
					Player.d_pressed = true
				KEY_Z:
					if DungeonGenerator.display_exit_prompt:
						DungeonGenerator.clear_dungeon()
						
						
		if not event.pressed:
			match event.keycode:
				KEY_A:
					Player.direction.x = 0 if not Player.d_pressed else 1
					Player.a_pressed = false
				KEY_W:
					Player.direction.y = 0 if not Player.s_pressed else 1
					Player.w_pressed = false
				KEY_S:
					Player.direction.y = 0 if not Player.w_pressed else -1
					Player.s_pressed = false
				KEY_D:
					Player.direction.x = 0 if not Player.a_pressed else -1
					Player.d_pressed = false
				
	if event is InputEventMouseButton:
		if event.pressed:
			match event.button_index:
				1:
					if Player.weapon_equipped():
						Player.equipped_weapon.start_attack()
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
					if Player.weapon_equipped():
						Player.equipped_weapon.end_attack()
						print("stop fire")
				
			#if Player.direction == Vector2(0, 0):
				#Player.moving = false
