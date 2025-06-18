extends magic_weapon

class_name staff

# the staff class will be entirely based on this
@export var effect_scene: String

var effect_node
var attacking: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	effect_node = load(effect_scene)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	super(delta)

func start_attack():
	attacking = true
	
func end_attack():
	pass

func _on_cast_timer_timeout() -> void:
	pass
	# weapon do the big bang or smth
	# highly dependent on the animations
