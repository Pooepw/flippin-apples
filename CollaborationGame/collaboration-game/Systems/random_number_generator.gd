extends Node

var rng

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rng = RandomNumberGenerator.new()

func set_rng_by_seed(seed_string):
	var hashed_seed = hash(seed_string)
	rng.seed = hashed_seed

func set_seed_randomly():
	rng.randomize()
