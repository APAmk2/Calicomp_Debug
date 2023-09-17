extends Node

var money = LoadSingleton.money
var settings_anim = false

var time = 0
var timeDirection = 1
var moveDuration = 0.25

func _process(delta):
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
	if(int(LoadSingleton.shop_items[1]) == 1):
		$"2D/room/interior/clay_homes".show()
	if(int(LoadSingleton.shop_items[2]) == 1):
		$"2D/room/interior/maneki".show()
	if(int(LoadSingleton.shop_items[3]) == 1):
		$"2D/room/interior/miki_pos".show()
	if(int(LoadSingleton.shop_items[4]) == 1):
		$"2D/room/interior/cutesy_pos".show()
	if(int(LoadSingleton.shop_items[5]) == 1):
		$"2D/room/interior/books".show()
	if(int(LoadSingleton.shop_items[6]) == 1):
		$"2D/room/interior/daruma".show()
	if(int(LoadSingleton.shop_items[7]) == 1):
		$"2D/room/interior/figure".show()
	if(int(LoadSingleton.shop_items[8]) == 1):
		$"2D/room/interior/movie".show()
	if(int(LoadSingleton.shop_items[9]) == 1):
		$"2D/room/interior/xmas".show()
	if(int(LoadSingleton.shop_items[10]) == 1):
		$"2D/room/interior/rom".show()
	if(int(LoadSingleton.shop_items[11]) == 1):
		$"2D/room/interior/crt".show()
	if(int(LoadSingleton.shop_items[12]) == 1):
		$"2D/room/interior/cyclone".show()
	if(int(LoadSingleton.shop_items[13]) == 1):
		$"2D/room/interior/plant".show()
	if(int(LoadSingleton.shop_items[16]) == 1):
		$"2D/room/interior/beer".show()
	if(int(LoadSingleton.shop_items[15]) == 1):
		$"2D/room/interior/banner".show()
	if(int(LoadSingleton.shop_items[14]) == 1):
		$"2D/room/interior/lamp".show()
	if(LoadSingleton.scanlines == 1):
		$scanlines.show()
	else:
		$scanlines.hide()
	$"Hud/funds".text += str(money)

func _on_to_work_button_up():
	get_tree().change_scene_to_file("res://resources/scenes/Main.tscn")

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

func _on_to_shop_button_up():
	get_tree().change_scene_to_file("res://resources/scenes/Shop.tscn")
