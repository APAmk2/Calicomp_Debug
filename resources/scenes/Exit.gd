extends Node2D

var inMenu = false
func _on_yes_pressed():
	if(inMenu):
		get_tree().quit()
	else:
		get_tree().change_scene_to_file("res://resources/scenes/Menu.tscn")
func _on_no_pressed():
	hide()

func _on_menu_but_pressed():
	inMenu = true
	$"2D/Hud/text".text = tr("QUITANSW")
	show()

func _on_quit_but_pressed():
	inMenu = false
	$"2D/Hud/text".text = tr("MENUANSW")
	show()
