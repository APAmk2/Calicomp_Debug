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

var layer: int = 0
var pages: int = 1
var nanoTableMode: bool = false
var app: String = "none"
var aeReaded: bool = 0
var dangeReaded: bool = 0
var mikiReaded: bool = 0
var TabletUnlockTime: int = 1.5
var nanoChoice: int
var dangeThreadsIndex: Array = ["", "3", "2", "1", "6", "5", "4", "7", "6", "5", "10", "9", "8", "3", "2", "1", "13", "12", "11", "14", "13", "12", "15", "14", "13", "16", "15", "14", "17", "16", "15", "18", "17", "16", "18", "17", "16", "19", "18", "17", "20", "19", "18", "21", "20", "19", "22", "21", "20", "22", "21", "20", "23", "22", "21"]
var WallPrices: Array = [200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 500, 500, 900, 1500, 1500, 10000]
var wPaperNames: Array = ["gray", "blue", "cream", "red", "pink", "black", "gray", "white", "green", "orange", "reddish", "red_lines", "leopard", "anime", "miki", "game", "doge"]
var tableNames: Array = ["leopard", "bullet", "red_lines", "default"]

func _ready():
	hide_elems()
	$"/root/Base/2D/room/room_walls".play(wPaperNames[GlobalVars.wallstype])
	if(!GlobalVars.datestring.is_empty()):
		$"Hud/home/day".text = GlobalVars.datestring
	if(GlobalVars.cur_day >= 2):
		if(!dangeReaded):
			$"2D/home/dangeru".play("alert")
		else:
			$"2D/home/dangeru".play("installed")
		$"Hud/home/dr_but".disabled = false
	if(GlobalVars.cur_day >= 3):
		if(!mikiReaded):
			$"2D/home/mikiapp".play("alert")
		else:
			$"2D/home/mikiapp".play("installed")
		$"Hud/home/miki_but".disabled = false
	if(GlobalVars.cur_day >= 5):
		$"2D/home/nanocamo".play("nanocamo")
		$"Hud/home/nanocamo_but".disabled = false

func _process(delta):
	if($"Hud/unlock".button_pressed):
		if TabletUnlockTime > 0:
			TabletUnlockTime -= delta
		else:
			$"sfx".stream = load("res://resources/Exported_Sounds/audiogroup_default/boot_up.ogg")
			$"sfx".play()
			show_elems()
			$"Hud/unlock".hide()
			$"2D/lockscrn".hide()
	if(!$"Hud/unlock".button_pressed):
		TabletUnlockTime = 1.5

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
	$"MusicPlayer".hide()
	if(!$"/root/Base/BGM".playing):
		$"MusicPlayer/BGM".playing = false
		$"/root/Base/BGM".playing = true
	$Hud/nanocamo/nanoApplyBtns.visible = false

func _on_ae_but_pressed():
	app = "ae"
	aeReaded = true
	$"2D/home/aug_eye".play("default")
	layer = 1
	homepage.play(app)
	hide_elems()
	homepage.show()
	for i in range (1, 4):
		var btn = get_node("Hud/app_base/app_but" + str(i))
		if(i + 3 * (GlobalVars.cur_day - 1) <= 15):
			btn.text = "NEWS" + str(i + 3 * (GlobalVars.cur_day - 1))
		if(i + 3 * (GlobalVars.cur_day - 1) > 15):
			btn.text = "NEWS" + str(i + 3 * (GlobalVars.cur_day - 1) + 3)
		btn.set("theme_override_colors/font_color",Color(0,0,0))
		btn.show()

func _on_dr_but_pressed():
	app = "dange"
	dangeReaded = true
	$"2D/home/dangeru".play("installed")
	layer = 1
	homepage.play(app)
	hide_elems()
	homepage.show()
	for i in range (1, 4):
		var btn = get_node("Hud/app_base/app_but" + str(i))
		btn.text = "THREADNAME" + dangeThreadsIndex[3 * (GlobalVars.cur_day - 2) + i]
		btn.set("theme_override_colors/font_color",Color(255,255,255))
		btn.show()

func _on_miki_but_pressed():
	app = "miki"
	mikiReaded = true
	$"2D/home/mikiapp".play("installed")
	layer = 1
	homepage.play(app)
	hide_elems()
	homepage.show()
	for i in range (1, 4):
		var btn = get_node("Hud/app_base/app_but" + str(i))
#		btn.text = "NEWS" + str(1 + 3 * (LoadSingleton.Day - 1) + (i - 1))
		btn.set("theme_override_colors/font_color",Color(0,0,0))
		btn.show()

func _on_music_but_pressed():
	app = "music"
	layer = 1
	hide_elems()
	$"/root/Base/BGM".playing = false
	$"MusicPlayer".show()

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
	else:
		if(layer == 2):
			if(app == "ae" || app == "dange" || app == "miki"):
				tablet_scroller.value = 0
				page.hide()
				tablet_scroller.hide()
				homepage.show()
				app_but1.show()
				app_but2.show()
				app_but3.show()
			else:
				if(app == "nanocamo"):
					pages = 1
					nanoTableMode = false
					page.hide()
					nano_choice.hide()
					nano_walls.hide()
					nano_table.hide()
					nano_page.hide()
					nano_1page.hide()
					homepage.show()
					nano_home_btns.show()
					$Hud/nanocamo/nanoApplyBtns.visible = false
	layer -= 1

func app_btns(extra_arg_0):
	if(app == "ae" && (extra_arg_0 + 3 * (GlobalVars.cur_day - 1)) <= 15):
		page.texture = load("res://resources/Export_Sprites/augmented_eye_long_base_spr_" + str(extra_arg_0 + 3 * (GlobalVars.cur_day - 1)) + ".png")
	else:
		if(app == "ae" && (extra_arg_0 + 3 * (GlobalVars.cur_day - 1)) > 15):
			page.texture = load("res://resources/Export_Sprites/augmented_eye_long_base_spr_" + str(extra_arg_0 + 3 * (GlobalVars.cur_day - 1) + 3) + ".png")
	if(app == "dange"):
		page.texture = load("res://resources/Export_Sprites/" + tr("DANGERU") + dangeThreadsIndex[3 * (GlobalVars.cur_day - 2) + extra_arg_0 ] + ".png")
	if(app == "miki"):
		page.texture = load("res://resources/Export_Sprites/miki_entry_" + str(1 + GlobalVars.cur_day + extra_arg_0 ) + ".png")
	layer = 2
	tablet_scroller.max_value = page.texture.get_height() - 260
	homepage.hide()
	app_but1.hide()
	app_but2.hide()
	app_but3.hide()
	page.show()
	tablet_scroller.show()

func nanoUpdPage():
	for i in range (1, 5):
		if( int(GlobalVars.walls[i + 4 * (pages - 1)]) == 1 && GlobalVars.wallstype != i + 4 * (pages - 1)):
			get_node("Hud/nanocamo/nanoApplyBtns/apply" + str(i)).text = "Apply"
		else:
			get_node("Hud/nanocamo/nanoApplyBtns/apply" + str(i)).text = "Set"
		if( int(GlobalVars.walls[i + 4 * (pages - 1)]) != 1):
			get_node("Hud/nanocamo/nanoApplyBtns/apply" + str(i)).text = "$" + str(WallPrices[i + 4 * (pages - 1)])

func nano_btns(extra_arg_0):
	if(!nanoTableMode):
		page.texture = load("res://resources/Export_Sprites/nanobase_walls_spr_" + str( extra_arg_0 ) + ".png")
	pages = extra_arg_0
	nanoUpdPage()

func nano_setwall(extra_arg_0):
	if(nanoTableMode):
		$"/root/Base/2D/room/interior/kotatsu".play(tableNames[extra_arg_0 - 1])
	else:
		if(int(GlobalVars.walls[extra_arg_0 + 4 * (pages - 1)]) == 1):
			$"/root/Base/2D/room/room_walls".play(wPaperNames[extra_arg_0 + 4 * (pages - 1)])
			GlobalVars.wallstype = extra_arg_0 + 4 * (pages - 1)
		elif(GlobalVars.jillwallet - WallPrices[extra_arg_0 + 4 * (pages - 1)] >= 0 && extra_arg_0 + 4 * (pages - 1) != nanoChoice):
			nanoChoice = extra_arg_0 + 4 * (pages - 1)
		elif(GlobalVars.jillwallet - WallPrices[extra_arg_0 + 4 * (pages - 1)] >= 0 && extra_arg_0 + 4 * (pages - 1) == nanoChoice):
			GlobalVars.jillwallet - WallPrices[extra_arg_0 + 4 * (pages - 1)]
			GlobalVars.walls[extra_arg_0 + 4 * (pages - 1)] = 1
		nanoUpdPage()
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
	nanoUpdPage()
	$Hud/nanocamo/nanoApplyBtns.visible = true

func _on_walls_but_pressed():
	page.texture = load("res://resources/Export_Sprites/nanobase_walls_spr_1.png")
	nanoTableMode = false
	pages = 1
	nano_page.show()

func _on_table_but_pressed():
	page.texture = load("res://resources/Export_Sprites/nanobase_table_spr_0.png")
	nanoTableMode = true
	nano_page.hide()

func _on_saveload_but_pressed():
	app = "saveload"
	layer = 1
	hide_elems()
