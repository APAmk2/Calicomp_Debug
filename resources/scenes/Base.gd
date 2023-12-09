extends Node

var settingsAnim: bool = false

var time = 0
var timeDirection = 1
var moveDuration = 0.25

func _ready():
	if(int(GlobalVars.shopitems[1]) == 1):
		$"2D/room/interior/clay_homes".show()
	if(int(GlobalVars.shopitems[2]) == 1):
		$"2D/room/interior/maneki".show()
	if(int(GlobalVars.shopitems[3]) == 1):
		$"2D/room/interior/miki_pos".show()
	if(int(GlobalVars.shopitems[4]) == 1):
		$"2D/room/interior/cutesy_pos".show()
	if(int(GlobalVars.shopitems[5]) == 1):
		$"2D/room/interior/books".show()
	if(int(GlobalVars.shopitems[6]) == 1):
		$"2D/room/interior/daruma".show()
	if(int(GlobalVars.shopitems[7]) == 1):
		$"2D/room/interior/figure".show()
	if(int(GlobalVars.shopitems[8]) == 1):
		$"2D/room/interior/movie".show()
	if(int(GlobalVars.shopitems[9]) == 1):
		$"2D/room/interior/xmas".show()
	if(int(GlobalVars.shopitems[10]) == 1):
		$"2D/room/interior/rom".show()
	if(int(GlobalVars.shopitems[11]) == 1):
		$"2D/room/interior/crt".show()
	if(int(GlobalVars.shopitems[12]) == 1):
		$"2D/room/interior/cyclone".show()
	if(int(GlobalVars.shopitems[13]) == 1):
		$"2D/room/interior/plant".show()
	if(int(GlobalVars.shopitems[16]) == 1):
		$"2D/room/interior/beer".show()
	if(int(GlobalVars.shopitems[15]) == 1):
		$"2D/room/interior/banner".show()
	if(int(GlobalVars.shopitems[14]) == 1):
		$"2D/room/interior/lamp".show()
	if(LoadSingleton.ScanlinesEnabled):
		$scanlines.show()
	else:
		$scanlines.hide()
	$"Hud/funds".text = tr("FUNDS") + str(GlobalVars.jillwallet)

func _process(delta):
	if (time > moveDuration or time < 0):
		timeDirection *= -1

	time += delta * timeDirection
	var t = time / moveDuration
	if(settingsAnim):
		$Settings.scale = lerp($Settings.scale, Vector2(1, 1), t)
	else:
		$Settings.scale = lerp($Settings.scale, Vector2(1, 0.1), t)

func ToWorkBtnUp():
	get_tree().change_scene_to_file("res://resources/scenes/Jukebox.tscn")

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

func ToShopBtnUp():
	get_tree().change_scene_to_file("res://resources/scenes/Shop.tscn")
