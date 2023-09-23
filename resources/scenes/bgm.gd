extends HSlider

@export
var busName = "BGM"

var busIndex: int

func _ready() -> void:
	busIndex = AudioServer.get_bus_index(busName)
	value = db_to_linear(AudioServer.get_bus_volume_db(busIndex))

func ValueChanged(value: float) -> void:
	AudioServer.set_bus_volume_db(busIndex, linear_to_db(value))

func BgmPlusPressed():
	value += 0.1
func BgmMinusPressed():
	value -= 0.1
