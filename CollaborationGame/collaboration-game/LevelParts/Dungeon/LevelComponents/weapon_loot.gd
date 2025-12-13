extends Node2D

var active = false

var pick_up_text

# loot is just the string
# loot image rips the icon from an instance
var loot
var loot_image

func _process(_delta: float) -> void:
	if active:
		pick_up_text.visible = true
	if not active and not pick_up_text == null and pick_up_text.visible:
		pick_up_text.visible = false 

# loot_item is the string to be instanced by the player when adding to inventory
func set_up_loot(loot_item):
	pick_up_text = get_node("PickupText")
	pick_up_text.visible = false
	loot = loot_item
	var loot_instance = load(loot).instantiate()
	var loot_instance_icon = loot_instance.get_node("WeaponIcon")
	loot_image = loot_instance_icon.texture
	get_node("LootImage").texture = loot_image
	loot_instance.queue_free()

func _on_pickup_area_body_entered(body: Node2D) -> void:
	if body is player:
		toggle_pickup_active(true)

func toggle_pickup_active(state: bool):
	active = state

func _on_pickup_area_body_exited(body: Node2D) -> void:
	if body is player:
		toggle_pickup_active(false)
