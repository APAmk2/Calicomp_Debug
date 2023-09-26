extends Node

var settingsAnim: bool = false

var time = 0
var timeDirection = 1
var moveDuration = 0.25

func _ready():
	if(int(LoadSingleton.ShopItems[1]) == 1):
		$"2D/room/interior/clay_homes".show()
	if(int(LoadSingleton.ShopItems[2]) == 1):
		$"2D/room/interior/maneki".show()
	if(int(LoadSingleton.ShopItems[3]) == 1):
		$"2D/room/interior/miki_pos".show()
	if(int(LoadSingleton.ShopItems[4]) == 1):
		$"2D/room/interior/cutesy_pos".show()
	if(int(LoadSingleton.ShopItems[5]) == 1):
		$"2D/room/interior/books".show()
	if(int(LoadSingleton.ShopItems[6]) == 1):
		$"2D/room/interior/daruma".show()
	if(int(LoadSingleton.ShopItems[7]) == 1):
		$"2D/room/interior/figure".show()
	if(int(LoadSingleton.ShopItems[8]) == 1):
		$"2D/room/interior/movie".show()
	if(int(LoadSingleton.ShopItems[9]) == 1):
		$"2D/room/interior/xmas".show()
	if(int(LoadSingleton.ShopItems[10]) == 1):
		$"2D/room/interior/rom".show()
	if(int(LoadSingleton.ShopItems[11]) == 1):
		$"2D/room/interior/crt".show()
	if(int(LoadSingleton.ShopItems[12]) == 1):
		$"2D/room/interior/cyclone".show()
	if(int(LoadSingleton.ShopItems[13]) == 1):
		$"2D/room/interior/plant".show()
	if(int(LoadSingleton.ShopItems[16]) == 1):
		$"2D/room/interior/beer".show()
	if(int(LoadSingleton.ShopItems[15]) == 1):
		$"2D/room/interior/banner".show()
	if(int(LoadSingleton.ShopItems[14]) == 1):
		$"2D/room/interior/lamp".show()
	if(LoadSingleton.ScanlinesEnabled):
		$scanlines.show()
	else:
		$scanlines.hide()
	$"Hud/funds".text = tr("FUNDS") + str(LoadSingleton.Money)

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
	get_tree().change_scene_to_file("res://resources/scenes/Main.tscn")

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
