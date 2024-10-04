extends Control

# access to the weapon TextureRect
var weapon_one_node
var weapon_two_node
var weapon_three_node

# set up access to texture nodes
func _ready() -> void:
	weapon_one_node = get_node("WeaponOne")
	weapon_two_node = get_node("WeaponTwo")
	weapon_three_node = get_node("WeaponThree")

# sets inventory icon to the texture given. textures for inventory are 92x92
func set_inventory_icon(texture, slot):
	match slot:
		1:
			weapon_one_node.set_texture(texture)
		2: 
			weapon_two_node.set_texture(texture)
		3: 
			weapon_three_node.set_texture(texture)
