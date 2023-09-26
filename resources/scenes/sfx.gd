extends HSlider

var busName: String = "SFX"
var busIndex: int

func _ready() -> void:
	busIndex = AudioServer.get_bus_index(busName)
	value_changed.connect(_on_value_changed)
	value = db_to_linear(AudioServer.get_bus_volume_db(busIndex))

func _on_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(busIndex, linear_to_db(value))

func _on_sfx_plus_pressed():
	value += 0.1
func _on_sfx_minus_pressed():
	value -= 0.1
