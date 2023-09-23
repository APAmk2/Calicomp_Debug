extends Node

var ngplus = false
var btnsAnim = false
var settingsAnim = false
@onready var pressanyText = $"Hud/pressany"

var time = 0
var timeDirection = 1
var moveDuration = 0.25

func _ready():
	var random = RandomNumberGenerator.new()
	random.randomize()
	$"Hud/random_text".text = tr("DEMONAME" + str(random.randi_range(1, 2))) + " " + ProjectSettings.get_setting("application/config/version")
	if(LoadSingleton.IsScanlines == 1):
		$scanlines.show()
	else:
		$scanlines.hide()
	if(ngplus):
		$"2D/Background".play("ngplus")
	else:
		if(!ngplus):
			$"2D/Background".play("ng")
	$"Hud/engine_ver".text = str(Engine.get_version_info().string)
	while($"Hud/pressany_fullbut".visible):
		pressanyText.show()
		await get_tree().create_timer(3.0).timeout
		pressanyText.hide()
		await get_tree().create_timer(0.5).timeout
func _on_pressany_fullbut_pressed():
	$click_to_start.playing = true
	$"Hud/TM".show()
	pressanyText.hide()
	$"Hud/pressany_fullbut".hide()
	$"Hud/quit_but".show()
	$"Hud/sett_but".show()
	$"Hud/load_but".show()
	$"Hud/ng_but".show()
	btnsAnim = true
	$"Hud/random_text".show()
	$"Hud/engine_ver".show()

func _process(delta):
	if (time > moveDuration or time < 0):
		timeDirection *= -1

	time += delta * timeDirection
	var t = time / moveDuration
	if(btnsAnim):
		$"Hud/quit_but".position = lerp($"Hud/quit_but".position, Vector2(904,559), t)
		$"Hud/sett_but".position = lerp($"Hud/sett_but".position, Vector2(702,557), t)
		$"Hud/load_but".position =  lerp($"Hud/load_but".position, Vector2(506,557), t)
		$"Hud/ng_but".position =  lerp($"Hud/ng_but".position, Vector2(302,557), t)
	if(settingsAnim):
		$Settings.scale = lerp($Settings.scale, Vector2(1, 1), t)
	else:
		if(!settingsAnim):
			$Settings.scale = lerp($Settings.scale, Vector2(1, 0.1), t)
	

func NgBtnUp():
	get_tree().change_scene_to_file("res://resources/scenes/Base.tscn")
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
