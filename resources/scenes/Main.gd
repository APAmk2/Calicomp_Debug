extends Node

var betaHud: bool = true
var settingsAnim: bool = false

var trackNum: int = 0
var prevTrackNum:int = -1

var time = 0
var timeDirection = 1
var moveDuration = 0.25

func _ready():
	PlayMusic(3)
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

func FindTrackByName(string):
	var findvar
	for i in range (1, 60):
		findvar = LoadSingleton.musicData[i][2].find(string)
		if(findvar == 0):
			return i

func PlayMusic(mode):
	match mode:
		0:
			prevTrackNum = trackNum
			trackNum -= 1
		1:
			prevTrackNum = trackNum
			trackNum += 1
			if(trackNum == 11): 
				trackNum = 0
		2:
			if(!$"Hud/miniJukebox/loop".button_pressed):
				prevTrackNum = trackNum
				if($"Hud/miniJukebox/shuffle".button_pressed):
					var random = RandomNumberGenerator.new()
					random.randomize()
					trackNum = random.randi_range(0, 11)
				else:
					trackNum += 1
	trackNum = clamp(trackNum, 0, 11)
	if(prevTrackNum == trackNum && !$"Hud/miniJukebox/loop".button_pressed):
		return
	var filename = LoadSingleton.musicData[FindTrackByName(LoadSingleton.musicPlaylist[trackNum])][1]
	$"BGM".stream = load("res://resources/Exported_Sounds/audiogroup_default/" + filename)
	$"BGM".play()
	for i in range (1, 3):
		get_node("Hud/miniJukebox/trackName" + str(i)).text = LoadSingleton.musicPlaylist[trackNum]
	$"2D/miniJukebox".texture = load("res://resources/Export_Sprites/small_jukebox_spr_0.png")

func PauseMusic():
	$"BGM".stream_paused = !$"BGM".stream_paused
	if($"BGM".stream_paused):
		$"2D/miniJukebox".texture = load("res://resources/Export_Sprites/small_jukebox_pause_spr_0.png")
	else:
		$"2D/miniJukebox".texture = load("res://resources/Export_Sprites/small_jukebox_spr_0.png")

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

func JukeboxBtnPressed():
	$"2D/miniJukebox".visible = !$"2D/miniJukebox".visible
	$"Hud/miniJukebox".visible = !$"Hud/miniJukebox".visible
