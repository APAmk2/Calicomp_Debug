extends Node2D

@onready var page_display = $"Hud/page"

var maxPages: int = 12
var curPage: int = 1

func _ready():
	UpdateLabels()
	UpdateBtns()
	UpdatePlaylist()

func UpdateLabels():
	for i in range (1, 6):
		var index = i + 5 * (curPage - 1)
		if (index <= 59):
			get_node("Hud/musicListNames/musicName" + str(i)).text = LoadSingleton.musicData[index][2]
		else:
			get_node("Hud/musicListNames/musicName" + str(i)).text = " "

func UpdateBtns():
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
		get_node("Hud/PlaylistSlotBtns/PlaylistSlot" + str(i)).text = LoadSingleton.musicPlaylist[i - 1]

func MusicBtnPressed(extra_arg_0):
	var index = extra_arg_0 + 5 * (curPage - 1)
	var firstNull = LoadSingleton.musicPlaylist.find("")
	if (firstNull >= 0):
		LoadSingleton.musicPlaylist[firstNull] = str(LoadSingleton.musicData[index][2])
		UpdatePlaylist()
	if(LoadSingleton.musicPlaylist.find("") == -1):
		$"Hud/tobar".disabled = false

func PlaylistBtnPressed(extra_arg_0):
	LoadSingleton.musicPlaylist[extra_arg_0 - 1] = ""
	UpdatePlaylist()

func TobarPressed():
	get_tree().change_scene_to_file("res://resources/scenes/Main.tscn")

func _on_page_forward_pressed():
	if((curPage + 1) <= maxPages):
		curPage += 1
	page_display.text = str(curPage) + "/" + str(maxPages)
	UpdateLabels()
	UpdateBtns()

func _on_page_backward_pressed():
	if((curPage - 1) > 0):
		curPage -= 1
	page_display.text = str(curPage) + "/" + str(maxPages)
	UpdateLabels()
	UpdateBtns()
