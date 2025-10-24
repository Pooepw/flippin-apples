extends mob

var arm_bow_node
var arm_bow_frames
var attacking = false

var body_node

func _ready():
	super()
	arm_bow_node = get_node("ArmBow")
	arm_bow_node.get_node("WeaponIcon").visible = false
	arm_bow_frames = arm_bow_node.get_node("WeaponSprites")
	body_node = get_node("EnemyBody")

func _on_vision_range_body_entered(body: Node2D) -> void:
	if body is player:
		attacking = true
		arm_bow_node.start_attack()

func _on_vision_range_body_exited(body: Node2D) -> void:
	if body is player:
		attacking = false

func _physics_process(delta: float) -> void:
	super(delta)
	if direction.x >= 0:
		body_node.flip_h = false
	elif direction.x < 0:
		body_node.flip_h = true
	if arm_bow_frames.animation == "Charging" and not arm_bow_frames.is_playing():
		arm_bow_node.end_attack()
	if attacking:
		if arm_bow_frames.animation == "Idle":
			arm_bow_node.start_attack()

func special_movement(delta):
	if not attacking:
		body_node.play()
		super(delta)
	else:
		body_node.stop()
