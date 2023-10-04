extends Node

var betaHud: bool = true
var settingsAnim: bool = false

var time = 0
var timeDirection = 1
var moveDuration = 0.25

func _ready():
	$"Hud/money".text = "$" + str(LoadSingleton.MoneyInBar)
	if(LoadSingleton.ScanlinesEnabled):
		$scanlines.show()
	else:
		$scanlines.hide()
	if(betaHud):
		$"2D/calihack".show()
	else:
		$"2D/calihack".hide()

func _process(delta):
	$"2D/fan".rotation_degrees -= 0.95
	if (time > moveDuration or time < 0):
		timeDirection *= -1

	time += delta * timeDirection
	var t = time / moveDuration
	if(settingsAnim):
		$Settings.scale = lerp($Settings.scale, Vector2(1, 1), t)
	else:
		$Settings.scale = lerp($Settings.scale, Vector2(1, 0.1), t)

func SettingsBtnPressed():
	if($Settings.visible):
		settingsAnim = false
		$settings.stream = load("res://resources/Exported_Sounds/audiogroup_default/loghide.ogg")
		$settings.play()
		await get_tree().create_timer(0.08).timeout
	else:
		$Settings.scale = Vector2(0.1, 1)
		settingsAnim = true
		$settings.stream = load("res://resources/Exported_Sounds/audiogroup_default/logshow.ogg")
		$settings.play()
	$Settings.visible = !$Settings.visible

func LoadBtnPressed():
	$"2D/LoadBar".visible = !$"2D/LoadBar".visible
