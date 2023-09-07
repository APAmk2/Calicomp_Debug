extends AnimatedSprite2D

var ch = 0
var ch_list = ["off", "burrito", "wk", "news", "dollar", "ramen", "yiik", "no_signal", "wrestle", "hassy"]
@onready var channel = $"../../Hud/channel"
func _ready():
	var roll = randi() % 9
	play(ch_list[roll])
	ch = roll
func _on_tv_but_pressed():
	if (ch >= 9):
		ch = 0
		channel.hide()
	else:
		ch += 1
	if (ch > 0):
		channel.hide()
		channel.text = "Ch" + str(ch)
		channel.show()
	play(ch_list[ch])
	await get_tree().create_timer(1.0).timeout
	channel.hide()
