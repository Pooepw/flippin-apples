extends Node2D

var gross_bubble_node = preload("res://NPCs/Mobs/Bosses/gross_bubble.tscn")

func perform_attack():
	var bubble_1 = gross_bubble_node.instantiate()
	set_up_bubble(bubble_1, Vector2(0, -1))
	var bubble_2 = gross_bubble_node.instantiate()
	set_up_bubble(bubble_2, Vector2(1, -1))
	var bubble_3 = gross_bubble_node.instantiate()
	set_up_bubble(bubble_3, Vector2(1, 0))
	var bubble_4 = gross_bubble_node.instantiate()
	set_up_bubble(bubble_4, Vector2(1, 1))
	var bubble_5 = gross_bubble_node.instantiate()
	set_up_bubble(bubble_5, Vector2(0, 1))
	var bubble_6 = gross_bubble_node.instantiate()
	set_up_bubble(bubble_6, Vector2(-1, 1))
	var bubble_7 = gross_bubble_node.instantiate()
	set_up_bubble(bubble_7, Vector2(-1, 0))
	var bubble_8 = gross_bubble_node.instantiate()
	set_up_bubble(bubble_8, Vector2(-1, -1))

func set_up_bubble(bubble, move_direction):
	bubble.set_up_collision(boss_mob)
	bubble.global_position = global_position
	bubble.direction = move_direction
	bubble.actual_damage = bubble.damage
	ProjectileHandler.add_child(bubble)
	bubble.get_node("LiveTimer").start()
