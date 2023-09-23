extends Node2D

@onready var homescreen = $"2D/homescreen"
@onready var page = $"2D/page"
@onready var homebtns = $"Hud/home"
@onready var slots = $"2D/slots"
@onready var slot_btns = $"Hud/slot_btns"
@onready var page_btns = $"Hud/page_btns"
var pages = 0
var in_menu = false
var saveload_mode = 0
var read: Array

func _on_save_but_pressed():
	pages = 0
	saveload_mode = 0
	page.texture = load("res://resources/Export_Sprites/savepage_spr_0.png")
	homescreen.hide()
	homebtns.hide()
	slots.show()
	slot_btns.show()
	page_btns.show()
	page.show()
	$"Hud/base_btns/back_but".show()

func _on_load_but_pressed():
	pages = 0
	saveload_mode = 1
	page.texture = load("res://resources/Export_Sprites/loadpage_spr_0.png")
	homescreen.hide()
	homebtns.hide()
	slots.show()
	slot_btns.show()
	page_btns.show()
	page.show()
	$"Hud/base_btns/back_but".show()

func _on_home_but_pressed():
	pages = 0
	page.hide()
	page_btns.hide()
	slot_btns.hide()
	slots.hide()
	homescreen.show()
	homebtns.show()
	hide()

func _on_back_but_pressed():
	pages = 0
	page.hide()
	page_btns.hide()
	slot_btns.hide()
	slots.hide()
	homescreen.show()
	homebtns.show()
	if(!in_menu):
		$"Hud/base_btns/back_but".hide()

func _on_menu_but_pressed():
	show()
	in_menu = true
	$"Hud/home/Save_but".disabled = true
func _on_saveload_but_pressed():
	$"2D/save_frame".hide()
	$"Hud/base_btns/home_but".hide()
	show()
	in_menu = false

func slot(but_num):
	if(saveload_mode == 1):
		if(LoadSingleton._load(but_num + 4 * pages)):
			if(LoadSingleton.stage == "apt"):
				get_tree().change_scene_to_file("res://resources/scenes/Base.tscn")
			else: 
				if(LoadSingleton.stage == "break"):
					get_tree().change_scene_to_file("res://resources/scenes/Main.tscn")
	else:
		if(saveload_mode == 0):
			LoadSingleton._save(but_num + 4 * pages)

func _on_slot_1_pressed():
	slot(1)
func _on_slot_2_pressed():
	slot(2)
func _on_slot_3_pressed():
	slot(3)
func _on_slot_4_pressed():
	slot(4)

func _on_1page_pressed():
	pages = 0
func _on_2page_pressed():
	pages = 1
func _on_3page_pressed():
	pages = 2
func _on_4page_pressed():
	pages = 3
func _on_5page_pressed():
	pages = 4
func _on_6page_pressed():
	pages = 5

