extends staff_attack

var attack_damage

var life_timer
const LIFE_TIME = 8

var blue_blood
var blue_blood_detector
var blue_detected = false
var blue_target
var blue_blood_direction
const BLUE_SPEED = 300

var red_blood
var red_blood_detector
var red_detected = false
var red_target
var red_blood_direction
const RED_SPEED = 300

func _physics_process(delta: float) -> void:
	if blue_detected and not blue_target == null:
		blue_blood_direction = blue_blood.global_position.direction_to(blue_target.global_position)
	if blue_target == null:
		blue_detected = false
	blue_blood.position += blue_blood_direction * BLUE_SPEED * delta
	
	if red_detected and not red_target == null:
		red_blood_direction = red_blood.global_position.direction_to(red_target.global_position)
	if red_target == null:
		red_detected = false
	red_blood.position += red_blood_direction * RED_SPEED * delta

func perform_attack(emitted_by, damage):
	attack_damage = damage
	ProjectileHandler.add_child(self)
	set_up_emitter(emitted_by)
	position = PlayerHandler.current_player.global_position
	set_up_blue()
	set_up_red()
	life_timer = get_node("LifeTimer")
	life_timer.start(LIFE_TIME)

func set_up_blue():
	blue_blood = get_node("BlueBlood")
	set_up_blood_area(blue_blood)
	blue_blood_detector = blue_blood.get_node("BlueBloodDetection")
	set_up_blood_detection(blue_blood_detector)
	blue_blood_direction = Vector2(-1, 0)

func set_up_red():
	red_blood = get_node("RedBlood")
	set_up_blood_area(red_blood)
	red_blood_detector = red_blood.get_node("RedBloodDetection")
	set_up_blood_detection(red_blood_detector)
	red_blood_direction = Vector2(1, 0)

func set_up_blood_area(attack_area):
	if emitter == CollisionHandler.EMITTER_TYPES.PLAYER:
		attack_area.set_collision_layer_value(1, false)
		attack_area.set_collision_mask_value(1, false)
		attack_area.set_collision_layer_value(7, true)
		attack_area.set_collision_mask_value(3, true)
		attack_area.set_collision_mask_value(5, true)
		attack_area.set_collision_mask_value(6, true)
	else:
		attack_area.set_collision_layer_value(1, false)
		attack_area.set_collision_mask_value(7, true)
		attack_area.set_collision_mask_value(3, true)
		attack_area.set_collision_layer_value(5, true)
		attack_area.set_collision_layer_value(5, true)

func set_up_blood_detection(attack_area):
	if emitter == CollisionHandler.EMITTER_TYPES.PLAYER:
		attack_area.set_collision_layer_value(1, false)
		attack_area.set_collision_mask_value(1, false)
		attack_area.set_collision_mask_value(6, true)
	else:
		attack_area.set_collision_layer_value(1, false)

func _on_life_timer_timeout() -> void:
	queue_free()

func _on_blue_blood_body_entered(body: Node2D) -> void:
	CollisionHandler.handle_collision(self, body, attack_damage)

func _on_red_blood_body_entered(body: Node2D) -> void:
	CollisionHandler.handle_collision(self, body, attack_damage)

func _on_blue_blood_detection_body_entered(body: Node2D) -> void:
	if not blue_detected:
		blue_detected = true
		blue_target = body

func _on_red_blood_detection_body_entered(body: Node2D) -> void:
	if not red_detected:
		red_detected = true
		red_target = body
