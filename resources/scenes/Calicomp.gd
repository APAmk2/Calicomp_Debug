extends Node

var karmotrine: int = 0
var adelhyde: int = 0
var flanerhyde: int = 0
var bronson: int = 0
var delta: int = 0

func _on_area_2d_area_entered(area):
	$"2D/shaker".texture = load("res://resources/Export_Sprites/shake_hover_spr_0.png") 
	if(area == $"2D/karmotrine/Area2D"):
		$"2D/karmotrine".inShaker = true
	if(area == $"2D/adelhyde/Area2D"):
		$"2D/adelhyde".inShaker = true
	if(area == $"2D/flanerhyde/Area2D"):
		$"2D/flanerhyde".inShaker = true
	if(area == $"2D/bronson/Area2D"):
		$"2D/bronson".inShaker = true
	if(area == $"2D/delta/Area2D"):
		$"2D/delta".inShaker = true

func _on_area_2d_area_exited(area):
	$"2D/shaker".texture = load("res://resources/Export_Sprites/shaker_spr_0.png")
	if(area == $"2D/karmotrine/Area2D"):
		$"2D/karmotrine".inShaker = false
	if(area == $"2D/adelhyde/Area2D"):
		$"2D/adelhyde".inShaker = false
	if(area == $"2D/flanerhyde/Area2D"):
		$"2D/flanerhyde".inShaker = false
	if(area == $"2D/bronson/Area2D"):
		$"2D/bronson".inShaker = false
	if(area == $"2D/delta/Area2D"):
		$"2D/delta".inShaker = false


func EmitSound(mode):
	if(mode):
		if($Hud/ice.button_pressed):
			$"sfx".stream = load("res://resources/Exported_Sounds/audiogroup_default/iceadd.ogg")
			$"sfx".play()
	else:
		if($Hud/age.button_pressed):
			$"sfx".stream = load("res://resources/Exported_Sounds/audiogroup_default/ageadd.ogg")
			$"sfx".play()
