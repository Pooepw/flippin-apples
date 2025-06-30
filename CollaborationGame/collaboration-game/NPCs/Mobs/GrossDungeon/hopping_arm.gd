extends hopping_mob

var hop_sprite
var idle_sprite

func _ready():
	super()
	hop_sprite = get_node("HopSprite")
	idle_sprite = get_node("IdleSprite")
	hop_sprite.visible = false

func _physics_process(delta: float) -> void:
	super(delta)
	if move_speed == 0:
		hop_sprite.visible = false
		idle_sprite.visible = true
	elif not move_speed == 0:
		hop_sprite.visible = true
		idle_sprite.visible = false
