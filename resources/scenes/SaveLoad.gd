extends Node2D

@onready var homescreen = $"2D/homescreen"
@onready var page = $"2D/page"
@onready var homebtns = $"Hud/home"
@onready var slots = $"2D/slots"
@onready var slot_btns = $"Hud/slot_btns"
@onready var page_btns = $"Hud/page_btns"
var pages = 0
var inMenu = false
var saveLoadMode = 0
var read: Array

func SaveBtnPressed():
	pages = 0
	saveLoadMode = 0
	page.texture = load("res://resources/Export_Sprites/savepage_spr_0.png")
	homescreen.hide()
	homebtns.hide()
	slots.show()
	slot_btns.show()
	page_btns.show()
	page.show()
	$"Hud/base_btns/back_but".show()

func LoadBtnPressed():
	pages = 0
	saveLoadMode = 1
	page.texture = load("res://resources/Export_Sprites/loadpage_spr_0.png")
	homescreen.hide()
	homebtns.hide()
	slots.show()
	slot_btns.show()
	page_btns.show()
	page.show()
	$"Hud/base_btns/back_but".show()

func HomeBtnPressed():
	pages = 0
	page.hide()
	page_btns.hide()
	slot_btns.hide()
	slots.hide()
	homescreen.show()
	homebtns.show()
	hide()

func BackBtnPressed():
	pages = 0
	page.hide()
	page_btns.hide()
	slot_btns.hide()
	slots.hide()
	homescreen.show()
	homebtns.show()
	if(!inMenu):
		$"Hud/base_btns/back_but".hide()

func MenuLoadBtnPressed():
	show()
	inMenu = true
	$"Hud/home/Save_but".disabled = true
func SaveloadBtnPressed():
	$"2D/save_frame".hide()
	$"Hud/base_btns/home_but".hide()
	show()
	inMenu = false

func SlotPressed(extra_arg_0):
	if(saveLoadMode == 1):
		if(LoadSingleton.Load(extra_arg_0 + 4 * pages)):
			if(LoadSingleton.Place == "apt"):
				get_tree().change_scene_to_file("res://resources/scenes/Base.tscn")
			else: 
				if(LoadSingleton.Place == "break"):
					get_tree().change_scene_to_file("res://resources/scenes/Main.tscn")
	else:
		if(saveLoadMode == 0):
			LoadSingleton.Save(extra_arg_0 + 4 * pages)

func PageBtnPressed(extra_arg_0):
	pages = extra_arg_0 - 1
