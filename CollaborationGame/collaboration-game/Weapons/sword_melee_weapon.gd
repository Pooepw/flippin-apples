extends melee_weapon

var hitbox

var swinging = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	hitbox = get_node("Hitbox")
	hitbox.monitoring = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	pass

func attack():
	super()
