extends melee_weapon

var strike_area
var shockwave_area

var strike_active = false
var shockwave_active = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	strike_area = get_node("StrikeArea")
	strike_area.monitoring = false
	shockwave_area = get_node("ShockwaveArea")
	shockwave_area.monitoring = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	pass

func attack():
	super()
