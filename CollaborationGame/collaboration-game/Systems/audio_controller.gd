extends Node

var audio_bus
var sound_bus
var music_bus

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sound_bus = AudioServer.get_bus_index("Sounds")
	music_bus = AudioServer.get_bus_index("Music")

func set_sound_level(bus_index, db_level):
	AudioServer.set_bus_volume_db(bus_index, db_level)

func toggle_mute_bus(bus_index):
	AudioServer.set_bus_mute(bus_index, not AudioServer.is_bus_mute(bus_index))
