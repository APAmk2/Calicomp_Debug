extends Node2D

var betaHud: bool = true

var maxPages: int = 12
var curPage: int = 1

func _ready():
	UpdateJukebox()
	UpdatePlaylist()
	if(GlobalVars.songnames.find("") == -1):
		$"Hud/tobar".disabled = false
	if(betaHud):
		$"2D/bg".texture = load("res://resources/Export_Sprites/alt_new_jukeframe_0.png")

func UpdateJukebox():
	for i in range (1, 6):
		var index = i + 5 * (curPage - 1)
		if (index <= 59):
			get_node("Hud/musicSlotBtns/musicSlot" + str(i)).text = LoadSingleton.musicData[index][2]
		else:
			get_node("Hud/musicSlotBtns/musicSlot" + str(i)).text = " "
	if (curPage == 1):
		$"Hud/page_backward".disabled = true
	else:
		$"Hud/page_backward".disabled = false
	if (curPage <= 11):
		$"Hud/page_forward".disabled = false
	else:
		$"Hud/page_forward".disabled = true

func UpdatePlaylist():
	for i in range (1, 13):
		get_node("Hud/PlaylistSlotBtns/PlaylistSlot" + str(i)).text = GlobalVars.songnames[i - 1]

func MusicBtnPressed(extra_arg_0):
	var index = extra_arg_0 + 5 * (curPage - 1)
	var firstNull = GlobalVars.songnames.find("")
	if (firstNull >= 0):
		GlobalVars.songnames[firstNull] = str(LoadSingleton.musicData[index][2])
		UpdatePlaylist()
		$"SFX".stream = load("res://resources/Exported_Sounds/audiogroup_default/jukeselect.ogg")
		$"SFX".play()
	if(GlobalVars.songnames.find("") == -1):
		$"Hud/tobar".disabled = false

func PlaylistBtnPressed(extra_arg_0):
	GlobalVars.songnames[extra_arg_0 - 1] = ""
	$"SFX".stream = load("res://resources/Exported_Sounds/audiogroup_default/prompt.ogg")
	$"SFX".play()
	if(GlobalVars.songnames.find("") != -1):
		$"Hud/tobar".disabled = true
	UpdatePlaylist()

func TobarPressed():
	get_tree().change_scene_to_file("res://resources/scenes/Main.tscn")

func PageBtnsPressed(extra_arg_0):
	if(extra_arg_0):
		if((curPage + 1) <= maxPages):
			curPage += 1
	else:
		if((curPage - 1) > 0):
			curPage -= 1
	$"SFX".stream = load("res://resources/Exported_Sounds/audiogroup_default/jukepick.ogg")
	$"SFX".play()
	$"Hud/page".text = str(curPage) + "/" + str(maxPages)
	UpdateJukebox()
