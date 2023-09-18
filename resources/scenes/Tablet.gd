extends Node

@onready var tablet_scroller = $"Hud/app_base/tablet_scroller"
@onready var page = $"2D/page"
@onready var homepage = $"2D/homepage"
@onready var home = $"2D/home"
@onready var home_btns = $"Hud/home"
@onready var app_but1 = $"Hud/app_base/app_but1"
@onready var app_but2 = $"Hud/app_base/app_but2"
@onready var app_but3 = $"Hud/app_base/app_but3"
@onready var nano_home_btns = $"Hud/nanocamo/homescreen"
@onready var nano_page = $"Hud/nanocamo/page_buts"
@onready var nano_1page = $"Hud/nanocamo/1page_but"
@onready var nano_choice = $"Hud/nanocamo/menu_choice"
@onready var nano_walls = $"Hud/nanocamo/walls_but"
@onready var nano_table = $"Hud/nanocamo/table_but"

var layer = 0
var pages = 1
var day = LoadSingleton.day
var nano_mode = 0
var app = "none"
var ae_read = 0
var dange_read = 0
var miki_read = 0
var wall_num = 0
var UnlockTime = 1.5
var dange_threads = ["", "3", "2", "1", "6", "5", "4", "7", "6", "5", "10", "9", "8", "3", "2", "1", "13", "12", "11", "14", "13", "12", "15", "14", "13", "16", "15", "14", "17", "16", "15", "18", "17", "16", "18", "17", "16", "19", "18", "17", "20", "19", "18", "21", "20", "19", "22", "21", "20", "22", "21", "20", "23", "22", "21"]
var walls = ["", "", "", "gray", "blue", "cream", "red", "pink", "black", "gray", "white", "green", "orange", "reddish", "red_lines", "leopard", "anime", "miki", "game", "doge"]
var table = ["leopard", "bullet", "red_lines", "default"]

func _ready():
	hide_elems()
	for i in range (1, 4):
		print(i)
		get_node("Hud/app_base/app_but" + str(i)).text = "NEWS" + str(1 + 3 * (day - 1) + (i - 1))
	$"/root/Base/2D/room/room_walls".play(walls[LoadSingleton.walls - 1 + 4])
	if(!LoadSingleton.day_str.is_empty()):
		$"Hud/home/day".text = LoadSingleton.day_str
	if(LoadSingleton.day >= 2):
		$"2D/home/dangeru".play("alert")
		$"Hud/home/dr_but".disabled = false
	if(LoadSingleton.day >= 3):
		$"2D/home/mikiapp".play("alert")
		$"Hud/home/miki_but".disabled = false
	if(LoadSingleton.day >= 5):
		$"2D/home/nanocamo".play("nanocamo")
		$"Hud/home/nanocamo_but".disabled = false
func _process(delta):
	if($"Hud/unlock".button_pressed):
		print("pressed")
		if UnlockTime > 0:
			UnlockTime -= delta
			print(UnlockTime)
		else:
			if UnlockTime <= 0:
				$"sfx".stream = load("res://resources/Exported_Sounds/audiogroup_default/boot_up.ogg")
				$"sfx".play()
				show_elems()
				$"Hud/unlock".hide()
				$"2D/lockscrn".hide()
	if(!$"Hud/unlock".button_pressed):
		UnlockTime = 1.5
func hide_elems():
	home.hide()
	home_btns.hide()
func show_elems():
	tablet_scroller.value = 0
	pages = 1
	home.show()
	home_btns.show()
	homepage.hide()
	page.hide()
	tablet_scroller.hide()
	app_but1.hide()
	app_but2.hide()
	app_but3.hide()
	nano_home_btns.hide()
	nano_page.hide()
	nano_choice.hide()
	nano_walls.hide()
	nano_table.hide()
	$"SaveLoad".hide()
func _on_ae_but_pressed():
	app = "ae"
	ae_read = 1
	layer = 1
	homepage.play(app)
	hide_elems()
	homepage.show()
	app_but1.set("theme_override_colors/font_color",Color(0,0,0))
	app_but1.show()
	app_but2.set("theme_override_colors/font_color",Color(0,0,0))
	app_but2.show()
	app_but3.set("theme_override_colors/font_color",Color(0,0,0))
	app_but3.show()
func _on_dr_but_pressed():
	app = "dange"
	dange_read = 1
	layer = 1
	homepage.play(app)
	hide_elems()
	homepage.show()
	app_but1.set("theme_override_colors/font_color",Color(255,255,255))
	app_but1.show()
	app_but2.set("theme_override_colors/font_color",Color(255,255,255))
	app_but2.show()
	app_but3.set("theme_override_colors/font_color",Color(255,255,255))
	app_but3.show()
func _on_miki_but_pressed():
	app = "miki"
	miki_read = 1
	layer = 1
	homepage.play(app)
	hide_elems()
	homepage.show()
	app_but1.set("theme_override_colors/font_color",Color(0,0,0))
	app_but1.show()
	app_but2.set("theme_override_colors/font_color",Color(0,0,0))
	app_but2.show()
	app_but3.set("theme_override_colors/font_color",Color(0,0,0))
	app_but3.show()
func _on_music_but_pressed():
	app = "music"
	layer = 1
	homepage.play(app)
	hide_elems()
	homepage.show()
func _on_home_but_pressed():
	show_elems()
	$"sfx".stream = load("res://resources/Exported_Sounds/audiogroup_default/cancel_sound.ogg")
	$"sfx".play()
	#a bug from original, but why not?
	if(layer == 2):
		$"sfx".play()
		$"sfx".play()
func _on_nanocamo_but_pressed():
	app = "nanocamo"
	layer = 1
	homepage.play(app)
	hide_elems()
	homepage.show()
	nano_home_btns.show()
func _on_back_but_pressed():
	if(layer == 1):
		show_elems()
	if(layer == 2):
		if(app == "ae" || app == "dange" || app == "miki"):
			tablet_scroller.value = 0
			page.hide()
			tablet_scroller.hide()
			homepage.show()
			app_but1.show()
			app_but2.show()
			app_but3.show()
		if(app == "nanocamo"):
			pages = 1
			nano_mode = 0
			page.hide()
			nano_choice.hide()
			nano_walls.hide()
			nano_table.hide()
			nano_page.hide()
			nano_1page.hide()
			homepage.show()
			nano_home_btns.show()
	layer -= 1
func app_btns(extra_arg_0):
	if(app == "ae" && (3 * day + extra_arg_0) < 15):
		page.texture = load("res://resources/Export_Sprites/augmented_eye_long_base_spr_" + str(3 * (day - 1) + extra_arg_0) + ".png")
	else:
		if(app == "ae" && (3 * day + extra_arg_0) > 15):
			page.texture = load("res://resources/Export_Sprites/augmented_eye_long_base_spr_" + str(3 * (day - 1) + extra_arg_0 + 3) + ".png")
	if(app == "dange"):
		page.texture = load("res://resources/Export_Sprites/dange_thread1_" + dange_threads[3 * (day - 2) + extra_arg_0 ] + ".png")
	if(app == "miki"):
		page.texture = load("res://resources/Export_Sprites/miki_entry_" + str(1 + day + extra_arg_0 ) + ".png")
	layer = 2
	tablet_scroller.max_value = page.texture.get_height() - 260
	homepage.hide()
	app_but1.hide()
	app_but2.hide()
	app_but3.hide()
	page.show()
	tablet_scroller.show()
func nano_btns(extra_arg_0):
	if(nano_mode == 0):
		page.texture = load("res://resources/Export_Sprites/nanobase_walls_spr_" + str( extra_arg_0 ) + ".png")
	pages = extra_arg_0
func nano_setwall(extra_arg_0):
	if(nano_mode == 0):
		$"/root/Base/2D/room/room_walls".play(walls[extra_arg_0 + 4 * pages])
		wall_num = extra_arg_0 + 4 * pages
	if(nano_mode == 1):
		$"/root/Base/2D/room/interior/kotatsu".play(table[extra_arg_0])
func _on_nano_about_but_pressed():
	page.texture = load("res://resources/Export_Sprites/nanobase_walls_spr_5.png")
	layer = 2
	homepage.hide()
	nano_home_btns.hide()
	page.show()
func _on_nano_mask_but_pressed():
	page.texture = load("res://resources/Export_Sprites/nanobase_walls_spr_6.png")
	layer = 2
	homepage.hide()
	nano_home_btns.hide()
	page.show()
func _on_nano_cust_but_pressed():
	page.texture = load("res://resources/Export_Sprites/nanobase_walls_spr_1.png")
	layer = 2
	homepage.hide()
	nano_home_btns.hide()
	page.show()
	nano_page.show()
	nano_1page.show()
	nano_choice.show()
	nano_walls.show()
	nano_table.show()
func _on_walls_but_pressed():
	page.texture = load("res://resources/Export_Sprites/nanobase_walls_spr_1.png")
	nano_mode = 0
	pages = 1
	nano_page.show()
func _on_table_but_pressed():
	page.texture = load("res://resources/Export_Sprites/nanobase_table_spr_0.png")
	nano_mode = 1
	nano_page.hide()
func _on_saveload_but_pressed():
	app = "saveload"
	layer = 1
	hide_elems()
