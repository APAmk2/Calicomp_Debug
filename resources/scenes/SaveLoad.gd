extends Node2D

@onready var slots = $"2D/slots"
@onready var slot_btns = $"Hud/slot_btns"
@onready var page_btns = $"Hud/page_btns"

var pages: int = 0
var inMenu: bool = false
var saveLoadMode: int = 0

func LoadSavesText():
	for i in range (1, 25):
		LoadSingleton.Load(i, false)

func LoadSavesInfo():
	LoadSavesText()
	for i in range (1, 5):
		var dateText = get_node("Hud/Savedates/saveDate" + str(i))
		var dayNum = get_node("Hud/Savedays/saveDay" + str(i))
		if(str(LoadSingleton.SaveDate[i + (4 * pages) - 1]).length() > 1):
			dateText.text = str(LoadSingleton.SaveDate[i + (4 * pages) - 1])
			dayNum.text = "Day " + str(int(LoadSingleton.SaveDay[i + (4 * pages) - 1])) + "- "
			if(LoadSingleton.SavePlace[i + (4 * pages) - 1] == "apt"):
				dayNum.text += "Room"
			else: 
				if(LoadSingleton.SavePlace[i + (4 * pages) - 1] == "break"):
					dayNum.text += "Break"
			dateText.show()
			dayNum.show()
		else:
			dateText.hide()
			dayNum.hide()

func SaveBtnPressed():
	pages = 0
	saveLoadMode = 0
	$"2D/page".texture = load("res://resources/Export_Sprites/savepage_spr_0.png")
	$"2D/homescreen".hide()
	$"Hud/home".hide()
	slots.show()
	slot_btns.show()
	page_btns.show()
	$"2D/page".show()
	$"Hud/base_btns/back_but".show()
	LoadSavesInfo()

func LoadBtnPressed():
	pages = 0
	saveLoadMode = 1
	$"2D/page".texture = load("res://resources/Export_Sprites/loadpage_spr_0.png")
	$"2D/homescreen".hide()
	$"Hud/home".hide()
	slots.show()
	slot_btns.show()
	page_btns.show()
	$"2D/page".show()
	$"Hud/base_btns/back_but".show()
	LoadSavesInfo()

func LoadBarBtnPressed():
	pages = 0
	saveLoadMode = 1
	slots.show()
	slot_btns.show()
	page_btns.show()
	LoadSavesInfo()

func HomeBtnPressed():
	pages = 0
	$"2D/page".hide()
	page_btns.hide()
	slot_btns.hide()
	slots.hide()
	$"2D/homescreen".show()
	$"Hud/home".show()
	for i in range (1, 5):
		var dateText = get_node("Hud/Savedates/saveDate" + str(i))
		var dayNum = get_node("Hud/Savedays/saveDay" + str(i))
		dateText.hide()
		dayNum.hide()
	hide()

func BackBtnPressed():
	pages = 0
	$"2D/page".hide()
	page_btns.hide()
	slot_btns.hide()
	slots.hide()
	$"2D/homescreen".show()
	$"Hud/home".show()
	for i in range (1, 5):
		var dateText = get_node("Hud/Savedates/saveDate" + str(i))
		var dayNum = get_node("Hud/Savedays/saveDay" + str(i))
		dateText.hide()
		dayNum.hide()
	if(!inMenu):
		$"Hud/base_btns/back_but".hide()

func MenuLoadBtnPressed():
	show()
	LoadSavesText()
	inMenu = true
	$"Hud/home/Save_but".disabled = true

func SaveloadBtnPressed():
	$"2D/save_frame".hide()
	$"Hud/base_btns/home_but".hide()
	show()
	inMenu = false

func SlotPressed(extra_arg_0):
	if(saveLoadMode == 1):
		if(LoadSingleton.Load(extra_arg_0 + 4 * pages, true)):
			if(GlobalVars.dayphase == "apt"):
				get_tree().change_scene_to_file("res://resources/scenes/Base.tscn")
			else: 
				if(GlobalVars.dayphase == "break"):
					get_tree().change_scene_to_file("res://resources/scenes/Main.tscn")
	else:
		LoadSingleton.Save(extra_arg_0 + 4 * pages)
		LoadSavesInfo()

func PageBtnPressed(extra_arg_0):
	pages = extra_arg_0 - 1
	LoadSavesInfo()
