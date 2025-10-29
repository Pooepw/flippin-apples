extends mob

var wire_wand_node
var wire_wand_frames
var following = true
var body

func _ready() -> void:
	super()
	wire_wand_node = get_node("WireWand")
	wire_wand_node.get_node("WeaponIcon").visible = false
	wire_wand_frames = wire_wand_node.get_node("WeaponSprites")
	body = get_node("EnemyBody")


func _physics_process(delta: float) -> void:
	if following:
		super(delta)
	if PlayerHandler.current_player.global_position.x < global_position.x and not body.flip_h:
		body.flip_h = true
		wire_wand_frames.flip_h = true
	elif PlayerHandler.current_player.global_position.x >= global_position.x and body.flip_h:
		body.flip_h = false
		wire_wand_frames.flip_h = false


func _on_vision_range_body_entered(body: Node2D) -> void:
	if body is player:
		following = false
		wire_wand_node.start_attack()

func _on_vision_range_body_exited(body: Node2D) -> void:
	if body is player:
		following = true
		wire_wand_node.end_attack()
