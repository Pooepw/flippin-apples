extends mob

class_name pulsing_mob

@export var knockback: int
@export var pulse_time: float = 1.0
@export var recede_time: float = 1.0

var pulse_timer
var recede_timer

var pulse_area
var recede_area

var pulse_sprite
var recede_sprite

func _ready():
	super()
	pulse_timer = get_node("PulseTimer")
	recede_timer = get_node("RecedeTimer")
	
	pulse_area = get_node("PulseArea")
	pulse_area.monitoring = false
	pulse_area.monitorable = false
	
	recede_area = get_node("RecedeArea")
	
	pulse_sprite = get_node("PulseSprite")
	recede_sprite = get_node("RecedeSprite")
	recede_sprite.visible = false
	pulse_timer.start(pulse_time)

func special_movement(delta):
	direction = Vector2(0,0)
	

func _on_pulse_timer_timeout() -> void:
	pulse_sprite.visible = true
	recede_sprite.visible = false
	pulse_area.monitoring = true
	pulse_area.monitorable = true
	recede_area.monitoring = false
	recede_area.monitorable = false
	recede_timer.start(recede_time)

func _on_recede_timer_timeout() -> void:
	pulse_sprite.visible = false
	recede_sprite.visible = true
	pulse_area.monitoring = false
	pulse_area.monitorable = false
	recede_area.monitoring = true
	recede_area.monitorable = true
	pulse_timer.start(pulse_time)


func _on_recede_area_body_entered(body: Node2D) -> void:
	if body is player:
		CollisionHandler.handle_collision(body, self)

func _on_pulse_area_body_entered(body: Node2D) -> void:
	if body is player:
		CollisionHandler.handle_collision(body, self, contact_damage * 2)
