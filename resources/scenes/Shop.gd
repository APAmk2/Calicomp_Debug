extends Node

@onready var page_display = $"Hud/page"
var MAX_PAGES = 2
var page = 1
var goyda = 1
var pricelist = [0, 500, 550, 300, 300, 350, 450, 350, 250, 1350, 2350, 1500, 800, 600, 500, 300, 1000, 300, 900, 600, 900]
var money = LoadSingleton.money

func btn(extra_arg_0):
	if(money - int(pricelist[extra_arg_0 + 10 * (page - 1)]) < 0 || int(LoadSingleton.shop_items[extra_arg_0 + 10 * (page - 1)]) == 1):
		pass;
	else:
		LoadSingleton.shop_items[extra_arg_0 + 10 * (page - 1)] = 1
		LoadSingleton.money -= int(pricelist[extra_arg_0 + 10 * (page - 1)])
		$"Hud/funds".text = tr("FUNDS") + str(LoadSingleton.money)

func _ready():
	page_display.text = str(page) + "/" + str(MAX_PAGES)
	$"Hud/funds".text = tr("FUNDS") + str(money)

func _process(delta):
	for i in range (1, 11):
		get_node("Hud/items_btns/item" + str(i)).text = "SHOPNAME" + str(i + 10 * (page - 1))
	if(page == 1):
		$"Hud/page_backward".disabled = true
	else:
		$"Hud/page_backward".disabled = false
	if(page == MAX_PAGES):
		$"Hud/page_forward".disabled = true
	else:
		$"Hud/page_forward".disabled = false

func _on_page_forward_pressed():
	if((page+1) <= MAX_PAGES):
		page += 1
	page_display.text = str(page) + "/" + str(MAX_PAGES)

func _on_page_backward_pressed():
	if((page-1) > 0):
		page -= 1
	page_display.text = str(page) + "/" + str(MAX_PAGES)

func _on_return_pressed():
	get_tree().change_scene_to_file("res://resources/scenes/Base.tscn")

func btn_hov(extra_arg_0):
	$"Hud/name".text = "SHOPNAME" + str(extra_arg_0 + 10 * (page - 1))
	$"Hud/description".text = "SHOPDESC" + str(extra_arg_0 + 10 * (page - 1))
