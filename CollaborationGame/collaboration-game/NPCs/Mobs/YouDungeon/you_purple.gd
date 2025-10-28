extends mob

var player_leg_node
var player_leg_frames
var body

func _ready() -> void:
	player_leg_node = get_node("PlayerLeg")
	player_leg_node.get_node("WeaponIcon").visible = false
	player_leg_frames = player_leg_node.get_node("WeaponSprites")
	player_leg_node.start_attack()
	body = get_node("EnemyBody")

func _physics_process(delta: float) -> void:
	super(delta)
	if PlayerHandler.current_player.global_position.x < global_position.x:
		body.flip_h = true
		player_leg_frames.flip_h = true
	else:
		body.flip_h = false
		player_leg_frames.flip_h = false
		
