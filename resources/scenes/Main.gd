extends Node

var beta_frame = true
var money_in_bar = LoadSingleton.money_in_bar
var settings_anim = false

var time = 0
var timeDirection = 1
var moveDuration = 0.25

func _process(delta):
	$"2D/fan".rotation_degrees -= 0.95
	if (time > moveDuration or time < 0):
		timeDirection *= -1

	time += delta * timeDirection
	var t = time / moveDuration
	if(settings_anim):
		$Settings.scale = lerp($Settings.scale, Vector2(1, 1), t)
	else:
		if(!settings_anim):
			$Settings.scale = lerp($Settings.scale, Vector2(1, 0.1), t)

func _ready():
	$"Hud/money".text = "$" + str(money_in_bar)
	if(LoadSingleton.scanlines == 1):
		$scanlines.show()
	else:
		$scanlines.hide()
	if(beta_frame):
		$"2D/calihack".show()
	else:
		if(!beta_frame):
			$"2D/calihack".hide()

func _on_sett_but_pressed():
	if($Settings.visible):
		settings_anim = false
		$settings.stream = load("res://resources/Exported_Sounds/audiogroup_default/loghide.ogg")
		$settings.play()
		await get_tree().create_timer(0.08).timeout
	else:
		$Settings.scale = Vector2(0.1, 1)
		settings_anim = true
		$settings.stream = load("res://resources/Exported_Sounds/audiogroup_default/logshow.ogg")
		$settings.play()
	$Settings.visible = !$Settings.visible
