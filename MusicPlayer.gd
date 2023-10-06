extends Node2D

var maxPages: int = 12
var curPage: int = 1

var trackNum: int = 0
var prevTrackNum:int = -1

func _ready():
	UpdateJukebox()

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
			if(trackNum == 60): 
				trackNum = 0
		2:
			if(!$"Hud/miniJukebox/loop".button_pressed):
				prevTrackNum = trackNum
				if($"Hud/miniJukebox/shuffle".button_pressed):
					var random = RandomNumberGenerator.new()
					random.randomize()
					trackNum = random.randi_range(0, 60)
				else:
					trackNum += 1
	trackNum = clamp(trackNum, 1, 60)
	if(prevTrackNum == trackNum && !$"Hud/miniJukebox/loop".button_pressed):
		return
	var filename = LoadSingleton.musicData[trackNum][1]
	$"BGM".stream = load("res://resources/Exported_Sounds/audiogroup_default/" + filename)
	$"BGM".play()
	for i in range (1, 3):
		get_node("Hud/miniJukebox/trackName" + str(i)).text = LoadSingleton.musicData[trackNum][2]

func PauseMusic():
	$"BGM".stream_paused = !$"BGM".stream_paused

func MusicBtnPressed(extra_arg_0):
	var index = extra_arg_0 + 5 * (curPage - 1)
	trackNum = index
	$"BGM".stream = load("res://resources/Exported_Sounds/audiogroup_default/" + str(LoadSingleton.musicData[index][1]))
	$"BGM".play()

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
