extends Node

var hide_all = false
var ngplus = false
var phrases = ["Good Bye Miss Bartender", "The Ballad of a Gay Ghost"]
var move = false
var settings_anim = false
@onready var pressany = $"Hud/pressany"

var time = 0
var timeDirection = 1
var moveDuration = 0.25

func _process(delta):
	if (time > moveDuration or time < 0):
		timeDirection *= -1

	time += delta * timeDirection
	var t = time / moveDuration
	if(move):
		$"Hud/quit_but".position = lerp($"Hud/quit_but".position, Vector2(904,559), t)
		$"Hud/sett_but".position = lerp($"Hud/sett_but".position, Vector2(702,557), t)
		$"Hud/load_but".position =  lerp($"Hud/load_but".position, Vector2(506,557), t)
		$"Hud/ng_but".position =  lerp($"Hud/ng_but".position, Vector2(302,557), t)
	if(settings_anim):
		$Settings.scale = lerp($Settings.scale, Vector2(1, 1), t)
	else:
		if(!settings_anim):
			$Settings.scale = lerp($Settings.scale, Vector2(1, 0.1), t)
	

func _ready():
	if(LoadSingleton.scanlines == 1):
		$scanlines.show()
	else:
		$scanlines.hide()
	if(ngplus):
		$"2D/Background".play("ngplus")
	else:
		if(!ngplus):
			$"2D/Background".play("ng")
	$"Hud/engine_ver".text = str(Engine.get_version_info().string)
	while(!hide_all):
		pressany.show()
		await get_tree().create_timer(3.0).timeout
		pressany.hide()
		await get_tree().create_timer(0.5).timeout
func _on_pressany_fullbut_pressed():
	$click_to_start.playing = true
	hide_all = true
	$"Hud/TM".show()
	pressany.hide()
	$"Hud/pressany_fullbut".hide()
	$"Hud/quit_but".show()
	$"Hud/sett_but".show()
	$"Hud/load_but".show()
	$"Hud/ng_but".show()
	move = true
	var roll = randi() % 2
	$"Hud/random_text".text = phrases[roll] + " " + ProjectSettings.get_setting("application/config/version")
	$"Hud/random_text".show()
	$"Hud/engine_ver".show()

func _on_ng_but_button_up():
	get_tree().change_scene_to_file("res://resources/scenes/Base.tscn")
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
