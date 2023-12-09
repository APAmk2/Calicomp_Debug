extends Node

@onready var sfx = $"sfx"
@onready var pressanyText = $"Hud/pressanyTxt"
@onready var scanlines = $scanlines
@onready var bg = $"2D/bg"
@onready var engineVer = $"Hud/engineVer"
@onready var pressanyBtn = $"Hud/pressanyBtn"
@onready var ngBtn = $"Hud/ngBtn"
@onready var loadBtn = $"Hud/loadBtn"
@onready var settingsBtn = $"Hud/settingsBtn"
@onready var quitBtn = $"Hud/quitBtn"
@onready var settingsWin = $"Settings"

var ngplus: bool = false
var btnsAnim: bool = false
var settingsAnim: bool = false
var randRoll: int

var time = 0
var timeDirection = 1
var moveDuration = 0.25

func _ready():
	var random = RandomNumberGenerator.new()
	random.randomize()
	randRoll = random.randi_range(1, 2)
	$"Hud/demonameTxt".text = tr("DEMONAME" + str(randRoll)) + " " + ProjectSettings.get_setting("application/config/version")
	if(LoadSingleton.ScanlinesEnabled):
		scanlines.show()
	else:
		scanlines.hide()
	if(ngplus):
		bg.play("ngplus")
	else:
		bg.play("ng")
	engineVer.text = str(Engine.get_version_info().string)
	while(pressanyBtn.visible):
		pressanyText.show()
		await get_tree().create_timer(3.0).timeout
		pressanyText.hide()
		await get_tree().create_timer(0.5).timeout

func _process(delta):
	if (time > moveDuration or time < 0):
		timeDirection *= -1
	time += delta * timeDirection
	var t = time / moveDuration
	if(btnsAnim):
		ngBtn.position =  lerp(ngBtn.position, Vector2(304,558), t)
		quitBtn.position = lerp(quitBtn.position, Vector2(890,558), t)
		settingsBtn.position = lerp(settingsBtn.position, Vector2(656,558), t)
		loadBtn.position =  lerp(loadBtn.position, Vector2(500,558), t)
	if(settingsAnim):
		settingsWin.scale = lerp(settingsWin.scale, Vector2(1, 1), t)
	else:
		settingsWin.scale = lerp(settingsWin.scale, Vector2(1, 0.1), t)

func PressanyBtnPressed():
	sfx.stream = load("res://resources/Exported_Sounds/audiogroup_default/click_to_start.ogg")
	sfx.play()
	$"Hud/copyright".show()
	pressanyText.hide()
	pressanyBtn.hide()
	ngBtn.show()
	settingsBtn.show()
	loadBtn.show()
	quitBtn.show()
	btnsAnim = true
	$"Hud/demonameTxt".show()
	engineVer.show()

func NgPressanyBtnPressed():
	GlobalVars.ResetAllVars()
	get_tree().change_scene_to_file("res://resources/scenes/Base.tscn")

func NgBtnPressed():
	$"2D/sitandplay".visible = !$"2D/sitandplay".visible 

func SettingsBtnPressed():
	if(settingsWin.visible):
		settingsAnim = false
		sfx.stream = load("res://resources/Exported_Sounds/audiogroup_default/loghide.ogg")
		sfx.play()
		await get_tree().create_timer(0.08).timeout
	else:
		settingsWin.scale = Vector2(0.1, 1)
		settingsAnim = true
		sfx.stream = load("res://resources/Exported_Sounds/audiogroup_default/logshow.ogg")
		sfx.play()
	settingsWin.visible = !settingsWin.visible
