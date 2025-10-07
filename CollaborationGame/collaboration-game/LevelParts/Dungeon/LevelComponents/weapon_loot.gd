extends Node2D

var active = false

var pick_up_text
var loot
var loot_image

func _process(delta: float) -> void:
	if active:
		pick_up_text.visible = true
	if not active and not pick_up_text == null and pick_up_text.visible:
		pick_up_text.visible = false 

func set_up_loot(loot_item):
	pick_up_text = get_node("PickupText")
	pick_up_text.visible = false
	loot = loot_item
	loot_image = loot_item.get_node("WeaponIcon").texture
	get_node("LootImage").texture = loot_image

func _on_pickup_area_body_entered(body: Node2D) -> void:
	if body is player:
		toggle_pickup_active(true)

func toggle_pickup_active(state: bool):
	active = state
