extends Node

var drink_a: Array = [0, 0, 0, 0, 0]
var drink_b: Array = [0, 0, 0, 0, 0]
var drink_a_name: String
var drink_b_name: String
var ingName: Array = ["adelhyde", "bronson", "delta", "flanergide", "karmotrine"]

func _input(event):
	if Input.is_action_just_pressed("decreaseAldehyde"):
		if($"Hud/slot1Btn".pressed):
			drink_a[0] -= 1
			drink_a[0] = clamp(drink_a[0], 0, 20)
		else:
			drink_b[0] -= 1
			drink_b[0] = clamp(drink_b[0], 0, 20)
		CalcVis(false)
	if Input.is_action_just_pressed("decreaseBronson"):
		if($"Hud/slot1Btn".pressed):
			drink_a[1] -= 1
			drink_a[1] = clamp(drink_a[1], 0, 20)
		else:
			drink_b[1] -= 1
			drink_b[1] = clamp(drink_b[1], 0, 20)
		CalcVis(false)
	if Input.is_action_just_pressed("decreaseDelta"):
		if($"Hud/slot1Btn".pressed):
			drink_a[2] -= 1
			drink_a[2] = clamp(drink_a[2], 0, 20)
		else:
			drink_b[2] -= 1
			drink_b[2] = clamp(drink_b[2], 0, 20)
		CalcVis(false)
	if Input.is_action_just_pressed("decreaseFlanergide"):
		if($"Hud/slot1Btn".pressed):
			drink_a[3] -= 1
			drink_a[3] = clamp(drink_a[3], 0, 20)
		else:
			drink_b[3] -= 1
			drink_b[3] = clamp(drink_b[3], 0, 20)
		CalcVis(false)
	if Input.is_action_just_pressed("decreaseKarmotrine"):
		if($"Hud/slot1Btn".pressed):
			drink_a[4] -= 1
			drink_a[4] = clamp(drink_a[4], 0, 20)
		else:
			drink_b[4] -= 1
			drink_b[4] = clamp(drink_b[4], 0, 20)
		CalcVis(false)

func CalcVis(reloadDrinks):
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
	if(reloadDrinks):
		if(!drink_a_name.is_empty() && $"Hud/slot1Btn".button_pressed):
			$"2D/shaker".texture = load("res://resources/Export_Sprites/" + str(LoadSingleton.RecipeData[FindDrinkRecipe(drink_a_name, 0)][1]))
			$"Hud/drinkName".text = drink_a_name
		elif(!drink_b_name.is_empty() && $"Hud/slot2Btn".button_pressed):
			$"2D/shaker".texture = load("res://resources/Export_Sprites/" + str(LoadSingleton.RecipeData[FindDrinkRecipe(drink_b_name, 0)][1]))
			$"Hud/drinkName".text = drink_b_name
		else:
			$"Hud/drinkName".text = ""
			$"2D/shaker".texture = load("res://resources/Export_Sprites/shaker_spr_0.png")

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

func GetDrinkInCurrSlot():
	if($Hud/slot1Btn.button_pressed):
		if(!drink_a_name.is_empty()):
			return true
		else:
			return false
	elif($Hud/slot2Btn.button_pressed):
		if(!drink_b_name.is_empty()):
			return true
		else:
			return false

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
		drink_a_name = ""
	elif($Hud/slot2Btn.button_pressed):
		drink_b = [0, 0, 0, 0, 0]
		drink_b_name = ""
	CalcVis(true)

func ResetBtnUp():
	$"Hud/resetBtn".position -= Vector2(0, 2)

func SlotBtnPressed(useless_bool):
	CalcVis(true)

func GenerateSearchStr(Ings):
	var str: String
	for i in Ings.size():
		str += str(Ings[i]) + " "
	str += str(0) + " "
	if ($Hud/age.button_pressed):
		str += str(1) + " "
	else:
		str += str(0) + " "
	if($Hud/ice.button_pressed):
		str += str(1)
	else:
		str += str(0)
	return str

func MixBtnPressed():
	var Ings: Array
	var SearchStr: String
	if($"Hud/slot1Btn".button_pressed):
		Ings = drink_a
	elif($"Hud/slot2Btn".button_pressed):
		Ings = drink_b
	
	SearchStr = GenerateSearchStr(Ings)
	
	if(FindDrinkRecipe(SearchStr, 2) != 0):
		if($Hud/slot1Btn.button_pressed):
			drink_a = [0, 0, 0, 0, 0]
			drink_a_name = LoadSingleton.RecipeData[FindDrinkRecipe(SearchStr, 2)][0]
		elif($Hud/slot2Btn.button_pressed):
			drink_b = [0, 0, 0, 0, 0]
			drink_b_name = LoadSingleton.RecipeData[FindDrinkRecipe(SearchStr, 2)][0]
		$"2D/shaker".texture = load("res://resources/Export_Sprites/" + str(LoadSingleton.RecipeData[FindDrinkRecipe(SearchStr, 2)][1]))
		$"Hud/drinkName".text = LoadSingleton.RecipeData[FindDrinkRecipe(SearchStr, 2)][0]
	else:
		if($Hud/slot1Btn.button_pressed):
			drink_a = [0, 0, 0, 0, 0]
		elif($Hud/slot2Btn.button_pressed):
			drink_b = [0, 0, 0, 0, 0]
		$"2D/shaker".texture = load("res://resources/Export_Sprites/glitchbottle_0.png")
		$"Hud/drinkName".text = "Днищеговнище"
	CalcVis(false)
		
	print(SearchStr)
	print(drink_a_name)
	print(drink_b_name)

func FindDrinkRecipe(string, mode):
	var findvar
	for i in range (1, 5):
		findvar = LoadSingleton.RecipeData[i][mode].find(string)
		if(findvar == -1 && i == 4):
			return 0
		if(findvar == 0):
			return i

