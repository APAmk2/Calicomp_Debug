extends Node2D

var fullscr: bool = false
var scanlines: bool = false
var readData: Array

func Load():
	var file = FileAccess.open("user://saves/Waifu Preferences.txt", FileAccess.READ)
	if(file.is_open()):
		print("Everything fine, loading Settings.")
		while(!file.eof_reached()):
			var check = file.get_line()
			if(check.length() <= 1):
				break
			else:
				readData.append(check)
		if(int(readData[0]) == 1):
			fullscr = true
		else:
			fullscr = false
		$"Hud/bgm".value = (float(readData[3]) - 20) / 100
		$"Hud/sfx".value = (float(readData[2]) - 20) / 100
		if(int(readData[1]) == 1):
			LoadSingleton.ScanlinesEnabled = true
		if(int(readData[1]) == 1):
			scanlines = true
		else:
			scanlines = false
		file = null
	else:
		print("Something went wrong, can't load Settings!")
func Save():
	var file = FileAccess.open("user://saves/Waifu Preferences.txt", FileAccess.WRITE)
	readData[3] = str(($"Hud/bgm".value * 100) + 20)
	readData[2] = str(($"Hud/sfx".value * 100) + 20)
	if(fullscr):
		readData[0] = "1 "
	else:
		readData[0] = "0 "
	if(LoadSingleton.ScanlinesEnabled):
		readData[1] = "1 "
	else:
		readData[1] = "0 "
	var saveData = PackedStringArray(readData)
	file.store_csv_line(saveData, "\n")
func _ready():
	Load()
	if(fullscr):
		$"2D/fullscreen_on".visible = true
		$"2D/windowed".visible = false
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		$"2D/fullscreen_on".visible = false
		$"2D/windowed".visible = true
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	if(LoadSingleton.ScanlinesEnabled):
		$"2D/filter/text".texture = load("res://resources/Export_Sprites/filteron_hovertxt_0.png")
		$"2D/filter/but".show()
		$"2D/filter/text".position = Vector2(204, 440)
	else:
		$"2D/filter/text".texture = load("res://resources/Export_Sprites/filteroff_idletxt_0.png")
		$"2D/filter/but".hide()
		$"2D/filter/text".position = Vector2(209, 440)
	$Hud/LangSel.selected = LoadSingleton.Lang
func FullscrBtnPressed():
	fullscr = true
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	$"2D/fullscreen_on".visible = true
	$"2D/windowed".visible = false

func WinModePressed():
	fullscr = false
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	$"2D/fullscreen_on".visible = false
	$"2D/windowed".visible = true

func SettingsBtnPressed():
	Save()

func ScanlinesBtnPressed():
	scanlines = !scanlines
	if(scanlines):
		LoadSingleton.ScanlinesEnabled = true
		$"2D/filter/text".texture = load("res://resources/Export_Sprites/filteron_hovertxt_0.png")
		$"2D/filter/but".show()
		$"2D/filter/text".position = Vector2(204, 440)
		$"../scanlines".show()
	else:
		LoadSingleton.ScanlinesEnabled = false
		$"2D/filter/text".texture = load("res://resources/Export_Sprites/filteroff_idletxt_0.png")
		$"2D/filter/but".hide()
		$"2D/filter/text".position = Vector2(209, 440)
		$"../scanlines".hide()
	print(LoadSingleton.ScanlinesEnabled)

func LangSelection(index):
	var locale : String = $Hud/LangSel.get_item_text(index)
	LoadSingleton.Lang = $Hud/LangSel.selected
	TranslationServer.set_locale(locale)
