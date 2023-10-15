extends Node

var drink_a: Array = [0, 0, 0, 0, 0]
var drink_b: Array = [0, 0, 0, 0, 0]
var ingName: Array = ["adelhyde", "bronson", "delta", "flanergide", "karmotrine"]

func _input(event):
	if Input.is_action_just_pressed("decreaseAldehyde"):
		if($"Hud/slot1Btn".pressed):
			drink_a[0] -= 1
			drink_a[0] = clamp(drink_a[0], 0, 20)
		else:
			drink_b[0] -= 1
			drink_b[0] = clamp(drink_b[0], 0, 20)
		CalcVis()
	if Input.is_action_just_pressed("decreaseBronson"):
		if($"Hud/slot1Btn".pressed):
			drink_a[1] -= 1
			drink_a[1] = clamp(drink_a[1], 0, 20)
		else:
			drink_b[1] -= 1
			drink_b[1] = clamp(drink_b[1], 0, 20)
		CalcVis()
	if Input.is_action_just_pressed("decreaseDelta"):
		if($"Hud/slot1Btn".pressed):
			drink_a[2] -= 1
			drink_a[2] = clamp(drink_a[2], 0, 20)
		else:
			drink_b[2] -= 1
			drink_b[2] = clamp(drink_b[2], 0, 20)
		CalcVis()
	if Input.is_action_just_pressed("decreaseFlanergide"):
		if($"Hud/slot1Btn".pressed):
			drink_a[3] -= 1
			drink_a[3] = clamp(drink_a[3], 0, 20)
		else:
			drink_b[3] -= 1
			drink_b[3] = clamp(drink_b[3], 0, 20)
		CalcVis()
	if Input.is_action_just_pressed("decreaseKarmotrine"):
		if($"Hud/slot1Btn".pressed):
			drink_a[4] -= 1
			drink_a[4] = clamp(drink_a[4], 0, 20)
		else:
			drink_b[4] -= 1
			drink_b[4] = clamp(drink_b[4], 0, 20)
		CalcVis()

func CalcVis():
	var IngNums: Array
	if($"Hud/slot1Btn".button_pressed):
		IngNums = drink_a
	elif($"Hud/slot2Btn".button_pressed):
		IngNums = drink_b
	for ing in ingName.size():
		for i in range (1, 21):
			var node = get_node("2D/" + ingName[ing] + "/slot" + str(i))
			if (i <= 0):
				pass
			if(i <= 10):
				if(IngNums[ing] + 1 > i):
					node.modulate = "ffffff"
				else:
					node.modulate = "383838"
			else:
				if(IngNums[ing] + 1 > i):
					node.visible = true
				else:
					node.visible = false
	var TotalNum = GetTotalIgredientsNum()
	for i in range (1, 21):
		var node = get_node("2D/totalIngs/slot" + str(i))
		if (i <= 0):
			pass
		else:
			if(TotalNum + 1 > i):
				node.visible = true
			else:
				node.visible = false

func _on_area_2d_area_entered(area):
	$"2D/shaker".texture = load("res://resources/Export_Sprites/shake_hover_spr_0.png") 
	for i in ingName.size():
		if(area == get_node("2D/igredients/" + ingName[i] + "/Area2D")):
			get_node("2D/igredients/" + ingName[i]).inShaker = true

func _on_area_2d_area_exited(area):
	$"2D/shaker".texture = load("res://resources/Export_Sprites/shaker_spr_0.png")
	for i in ingName.size():
		if(area == get_node("2D/igredients/" + ingName[i] + "/Area2D")):
			get_node("2D/igredients/" + ingName[i]).inShaker = false

func GetTotalIgredientsNum():
	if($Hud/slot1Btn.button_pressed):
		return drink_a[0] + drink_a[1] + drink_a[2] + drink_a[3] + drink_a[4]
	elif($Hud/slot2Btn.button_pressed):
		return drink_b[0] + drink_b[1] + drink_b[2] + drink_b[3] + drink_b[4]

func EmitSound(mode):
	if(mode):
		if($Hud/ice.button_pressed):
			$"sfx".stream = load("res://resources/Exported_Sounds/audiogroup_default/iceadd.ogg")
	else:
		if($Hud/age.button_pressed):
			$"sfx".stream = load("res://resources/Exported_Sounds/audiogroup_default/ageadd.ogg")
	$"sfx".play()

func ResetBtnDN():
	$"Hud/resetBtn".position += Vector2(0, 2)
	if($Hud/slot1Btn.button_pressed):
		drink_a = [0, 0, 0, 0, 0]
	elif($Hud/slot2Btn.button_pressed):
		drink_b = [0, 0, 0, 0, 0]
	CalcVis()

func ResetBtnUp():
	$"Hud/resetBtn".position -= Vector2(0, 2)

func SlotBtnPressed(useless_bool):
	CalcVis()
