extends Node2D

var fullscr = false
var filter = false
var read = []

func _load():
	var file = FileAccess.open("user://saves/Waifu Preferences.txt", FileAccess.READ)
	if(file.is_open()):
		print("Everything fine, loading Settings.")
		while(!file.eof_reached()):
			var check = file.get_line()
			if(check.length() <= 1):
				break
			else:
				read.append(check)
		if(read[0] == "1 "):
			fullscr = true
		else:
			if(read[0] == "0 "):
				fullscr = false
		$"Hud/bgm".value = (float(read[3]) - 20) / 100
		$"Hud/sfx".value = (float(read[2]) - 20) / 100
		LoadSingleton.scanlines = int(read[1])
		if(read[1] == "1 "):
			filter = true
		else:
			filter = false
		file = null
	else:
		print("Something went wrong, can't load Settings!")
func _save():
	var file = FileAccess.open("user://saves/Waifu Preferences.txt", FileAccess.WRITE)
	read[3] = str(($"Hud/bgm".value * 100) + 20)
	read[2] = str(($"Hud/sfx".value * 100) + 20)
	if(fullscr):
		read[0] = "1 "
	else:
		read[0] = "0 "
	if(LoadSingleton.scanlines == 1):
		read[1] = "1 "
	else:
		read[1] = "0 "
	var save = PackedStringArray(read)
	file.store_csv_line(save, "\n")
func _ready():
	_load()
	if(fullscr):
		$"2D/fullscreen_on".visible = true
		$"2D/windowed".visible = false
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		$"2D/fullscreen_on".visible = false
		$"2D/windowed".visible = true
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	if(LoadSingleton.scanlines == 1):
		$"2D/filter/text".texture = load("res://resources/Export_Sprites/filteron_hovertxt_0.png")
		$"2D/filter/but".show()
		$"2D/filter/text".position = Vector2(204, 440)
	else:
		$"2D/filter/text".texture = load("res://resources/Export_Sprites/filteroff_idletxt_0.png")
		$"2D/filter/but".hide()
		$"2D/filter/text".position = Vector2(209, 440)
func _on_fullscreen_but_pressed():
	fullscr = true
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	$"2D/fullscreen_on".visible = true
	$"2D/windowed".visible = false

func _on_window_but_pressed():
	fullscr = false
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	$"2D/fullscreen_on".visible = false
	$"2D/windowed".visible = true

func _on_sett_but_pressed():
	_save()

func _on_filter_but_pressed():
	filter = !filter
	if(filter):
		LoadSingleton.scanlines = 1
		$"2D/filter/text".texture = load("res://resources/Export_Sprites/filteron_hovertxt_0.png")
		$"2D/filter/but".show()
		$"2D/filter/text".position = Vector2(204, 440)
		$"../scanlines".show()
	else:
		LoadSingleton.scanlines = 0
		$"2D/filter/text".texture = load("res://resources/Export_Sprites/filteroff_idletxt_0.png")
		$"2D/filter/but".hide()
		$"2D/filter/text".position = Vector2(209, 440)
		$"../scanlines".hide()
	print(LoadSingleton.scanlines)
