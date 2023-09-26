extends AnimatedSprite2D

@onready var screen = $"../../Hud/channel"

var channel: int = 0
var channelList: Array = ["off", "burrito", "wk", "news", "dollar", "ramen", "yiik", "no_signal", "wrestle", "hassy"]

func _ready():
	var roll = randi() % 9
	play(channelList[roll])
	channel = roll

func _on_tv_but_pressed():
	if (channel >= 9):
		channel = 0
		screen.hide()
	else:
		channel += 1
	if (channel > 0):
		screen.hide()
		screen.text = "Ch" + str(channel)
		screen.show()
	play(channelList[channel])
	await get_tree().create_timer(1.0).timeout
	screen.hide()
