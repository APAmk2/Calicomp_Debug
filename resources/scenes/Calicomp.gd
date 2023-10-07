extends Node

var karmotrine: int = 0
var adelhyde: int = 0
var flanergide: int = 0
var bronson: int = 0
var delta: int = 0

func _input(event):
	if Input.is_action_just_pressed("decreaseAldehyde"):
		adelhyde -= 1
		adelhyde = clamp(adelhyde, 0, 20)
		CalcFalseVis(adelhyde, "adelhyde")
	if Input.is_action_just_pressed("decreaseBronson"):
		bronson -= 1
		bronson = clamp(bronson, 0, 20)
		CalcFalseVis(bronson, "bronson")
	if Input.is_action_just_pressed("decreaseDelta"):
		delta -= 1
		delta = clamp(delta, 0, 20)
		CalcFalseVis(delta, "delta")
	if Input.is_action_just_pressed("decreaseFlanergide"):
		flanergide -= 1
		flanergide = clamp(flanergide, 0, 20)
		CalcFalseVis(flanergide, "flanergide")
	if Input.is_action_just_pressed("decreaseKarmotrine"):
		karmotrine -= 1
		karmotrine = clamp(karmotrine, 0, 20)
		CalcFalseVis(karmotrine, "karmotrine")

func CalcFalseVis(numForRevert, ingName):
	var revertNum = 20 - numForRevert
	var totalRevertNum = 20 - GetTotalIgredientsNum()
	for i in range(20, 20 - revertNum , -1):
		if(i > 0 && i <= 10):
			get_node("2D/" + ingName + "/slot" + str(i)).modulate = "383838"
		else:
			get_node("2D/" + ingName + "/slot" + str(i)).visible = false
	for i in range(20, 20 - totalRevertNum , -1):
		if(i > 0):
			get_node("2D/totalIngs/slot" + str(i)).visible = false

func _on_area_2d_area_entered(area):
	$"2D/shaker".texture = load("res://resources/Export_Sprites/shake_hover_spr_0.png") 
	if(area == $"2D/igredients/karmotrine/Area2D"):
		$"2D/igredients/karmotrine".inShaker = true
	if(area == $"2D/igredients/adelhyde/Area2D"):
		$"2D/igredients/adelhyde".inShaker = true
	if(area == $"2D/igredients/flanergide/Area2D"):
		$"2D/igredients/flanergide".inShaker = true
	if(area == $"2D/igredients/bronson/Area2D"):
		$"2D/igredients/bronson".inShaker = true
	if(area == $"2D/igredients/delta/Area2D"):
		$"2D/igredients/delta".inShaker = true

func _on_area_2d_area_exited(area):
	$"2D/shaker".texture = load("res://resources/Export_Sprites/shaker_spr_0.png")
	if(area == $"2D/igredients/karmotrine/Area2D"):
		$"2D/igredients/karmotrine".inShaker = false
	if(area == $"2D/igredients/adelhyde/Area2D"):
		$"2D/igredients/adelhyde".inShaker = false
	if(area == $"2D/igredients/flanergide/Area2D"):
		$"2D/igredients/flanergide".inShaker = false
	if(area == $"2D/igredients/bronson/Area2D"):
		$"2D/igredients/bronson".inShaker = false
	if(area == $"2D/igredients/delta/Area2D"):
		$"2D/igredients/delta".inShaker = false

func GetTotalIgredientsNum():
	return karmotrine + adelhyde + flanergide + bronson + delta

func EmitSound(mode):
	if(mode):
		if($Hud/ice.button_pressed):
			$"sfx".stream = load("res://resources/Exported_Sounds/audiogroup_default/iceadd.ogg")
			$"sfx".play()
	else:
		if($Hud/age.button_pressed):
			$"sfx".stream = load("res://resources/Exported_Sounds/audiogroup_default/ageadd.ogg")
			$"sfx".play()
