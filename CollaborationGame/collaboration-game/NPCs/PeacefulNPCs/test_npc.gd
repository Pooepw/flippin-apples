extends Node2D

var text_list = ["This is a test NPC.", "I am really hungry.", "Please gib bean."]

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is player:
		pass
