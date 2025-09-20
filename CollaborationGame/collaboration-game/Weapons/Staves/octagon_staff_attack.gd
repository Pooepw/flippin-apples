extends staff_attack

var direction = Vector2(0,0)
var pellet_area
var life_timer

const SPEED = 800
const LIFE_TIME = 8

func _physics_process(delta: float) -> void:
	if not direction == Vector2(0,0):
		position += direction * delta * SPEED

func perform_single_attack(emitted_by, damage, new_direction):
	if emitted_by is player:
		emitter = CollisionHandler.EMITTER_TYPES.PLAYER
	else: 
		emitter = CollisionHandler.EMITTER_TYPES.MOB
	position = emitted_by.global_position
	direction = new_direction
	const DUMMY_VECTOR = Vector2(0,0)
	rotation = DUMMY_VECTOR.angle_to_point(new_direction)
	life_timer = get_node("LifeTimer")
	set_up_hit_area()
	ProjectileHandler.add_child(self)
	life_timer.start(LIFE_TIME)

func set_up_hit_area():
	pellet_area = get_node("AttackArea")
	if emitter == CollisionHandler.EMITTER_TYPES.PLAYER:
		pellet_area.set_collision_layer_value(1, false)
		pellet_area.set_collision_mask_value(1, false)
		pellet_area.set_collision_layer_value(7, true)
		pellet_area.set_collision_mask_value(3, true)
		pellet_area.set_collision_mask_value(5, true)
		pellet_area.set_collision_mask_value(6, true)
	else:
		pellet_area.set_collision_layer_value(1, false)
		pellet_area.set_collision_mask_value(7, true)
		pellet_area.set_collision_mask_value(3, true)
		pellet_area.set_collision_layer_value(5, true)
		pellet_area.set_collision_layer_value(5, true)

func _on_attack_area_body_entered(body: Node2D) -> void:
	CollisionHandler.handle_collision(self, body)


func _on_life_timer_timeout() -> void:
	queue_free()
