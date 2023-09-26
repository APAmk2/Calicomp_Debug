extends Node

@onready var page_display = $"Hud/page"

var maxPages: int = 2
var curPage: int = 1
var itemChoice: int
var pricelist: Array = [0, 500, 550, 300, 300, 350, 450, 350, 250, 1350, 2350, 1500, 800, 600, 500, 300, 1000, 300, 900, 600, 900]

func btn(extra_arg_0):
	if(LoadSingleton.Money - int(pricelist[extra_arg_0 + 10 * (curPage - 1)]) < 0 || int(LoadSingleton.ShopItems[extra_arg_0 + 10 * (curPage - 1)]) == 1):
		pass;
	else:
		if(itemChoice != extra_arg_0 + 10 * (curPage - 1)):
			itemChoice = extra_arg_0 + 10 * (curPage - 1)
			$"Hud/name".text = "SHOPNAME" + str(extra_arg_0 + 10 * (curPage - 1))
			$"Hud/description".text = "Are you sure?"
			$"sfx".stream = load("res://resources/Exported_Sounds/audiogroup_default/prompt.ogg")
			$"sfx".play()
			pass
		else:
			$"Hud/description".text = "Good Choice..."
			LoadSingleton.ShopItems[extra_arg_0 + 10 * (curPage - 1)] = 1
			LoadSingleton.Money -= int(pricelist[extra_arg_0 + 10 * (curPage - 1)])
			$"Hud/funds".text = tr("FUNDS") + str(LoadSingleton.Money)
			$"sfx".stream = load("res://resources/Exported_Sounds/audiogroup_default/glassserve.ogg")
			$"sfx".play()

func _ready():
	page_display.text = str(curPage) + "/" + str(maxPages)
	$"Hud/funds".text = tr("FUNDS") + str(LoadSingleton.Money)

func _process(_delta):
	for i in range (1, 11):
		get_node("Hud/items_btns/item" + str(i)).text = "SHOPNAME" + str(i + 10 * (curPage - 1))
	if(curPage == 1):
		$"Hud/page_backward".disabled = true
	else:
		$"Hud/page_backward".disabled = false
	if(curPage == maxPages):
		$"Hud/page_forward".disabled = true
	else:
		$"Hud/page_forward".disabled = false

func _on_page_forward_pressed():
	if((curPage + 1) <= maxPages):
		curPage += 1
	page_display.text = str(curPage) + "/" + str(maxPages)

func _on_page_backward_pressed():
	if((curPage - 1) > 0):
		curPage -= 1
	page_display.text = str(curPage) + "/" + str(maxPages)

func _on_return_pressed():
	get_tree().change_scene_to_file("res://resources/scenes/Base.tscn")

func btn_hov(extra_arg_0):
	$"Hud/name".text = "SHOPNAME" + str(extra_arg_0 + 10 * (curPage - 1))
	$"Hud/description".text = "SHOPDESC" + str(extra_arg_0 + 10 * (curPage - 1))
