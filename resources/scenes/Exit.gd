extends Node2D

var in_menu = false
func _on_yes_pressed():
	if(in_menu):
		get_tree().quit()
	else:
		get_tree().change_scene_to_file("res://resources/scenes/Menu.tscn")
func _on_no_pressed():
	hide()

func _on_menu_but_pressed():
	in_menu = true
	$"2D/Hud/text".text = tr("QUITANSW")
	show()

func _on_quit_but_pressed():
	in_menu = false
	$"2D/Hud/text".text = tr("MENUANSW")
	show()
