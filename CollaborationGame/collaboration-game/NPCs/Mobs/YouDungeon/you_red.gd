extends directional_mob

var screen_slammer_node
var screen_slammer_frames

func _ready():
	super()
	screen_slammer_node = get_node("ScreenSlammer")
	screen_slammer_node.get_node("WeaponIcon").visible = false
	screen_slammer_frames = screen_slammer_node.get_node("WeaponSprites")
	screen_slammer_node.start_attack()
	

func _physics_process(delta: float) -> void:
	super(delta)
	if screen_slammer_frames.animation == "Charging" and not screen_slammer_frames.is_playing():
		screen_slammer_node.end_attack()
	if screen_slammer_frames.animation == "Idle":
		screen_slammer_node.start_attack()
