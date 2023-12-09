extends Node

var drink_a: Array = [0, 0, 0, 0, 0]
var drink_b: Array = [0, 0, 0, 0, 0]
var drink_a_name: String
var drink_b_name: String
var MixStarted: bool = false
var LongMix: bool = false
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
	if(!MixStarted && GetDrinkInCurrSlot()):
		for i in range (1, 21):
			var node = get_node("2D/totalIngs/slot" + str(i))
			if (i <= 0):
				pass
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
			$"sfx".play()
	else:
		if($Hud/age.button_pressed):
			$"sfx".stream = load("res://resources/Exported_Sounds/audiogroup_default/ageadd.ogg")
			$"sfx".play()

func Reset():
	if($Hud/slot1Btn.button_pressed):
		drink_a = [0, 0, 0, 0, 0]
		drink_a_name = ""
	elif($Hud/slot2Btn.button_pressed):
		drink_b = [0, 0, 0, 0, 0]
		drink_b_name = ""
	CalcVis(true)

func ResetBtnDN():
	$"Hud/resetBtn".position += Vector2(0, 2)
	Reset()

func ResetBtnUp():
	$"Hud/resetBtn".position -= Vector2(0, 2)

func SlotBtnPressed(useless_bool):
	MixStarted = false
	CalcVis(true)

func GenerateSearchStr(Ings):
	var str: String
	for i in Ings.size():
		str += str(Ings[i]) + " "
	if(LongMix):
		str += str(1) + " "
	else:
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

var Ings: Array = [0, 0, 0, 0, 0]
var SearchStr: String
var KarmoSearchStr: String
var SearchArr: Array

func MixBtnPressed():
	MixStarted = !MixStarted
	if(GetTotalIgredientsNum() < 1 && MixStarted):
		return
	if(MixStarted):
		$"2D/shaker/AnimationPlayer".speed_scale = 2.0
		$"2D/shaker".texture = load("res://resources/Export_Sprites/shaker_spr_0.png")
		LongMix = false
		if($"Hud/slot1Btn".button_pressed):
			Ings = drink_a
		elif($"Hud/slot2Btn".button_pressed):
			Ings = drink_b
		$"2D/shaker/AnimationPlayer".play("shaker_shake")
		await get_tree().create_timer(4.0).timeout
		$"2D/shaker/AnimationPlayer".speed_scale = 4.0
		LongMix = true
	else:
		SearchStr = GenerateSearchStr(Ings)
		Dialogic.VAR.KarmoLvl = Ings[4]
		Ings[4] = -1
		KarmoSearchStr = GenerateSearchStr(Ings)
		SearchArr = [SearchStr, KarmoSearchStr]
		var isDrink: bool = false
		
		for i in range (0, 2):
			if(FindDrinkRecipe(SearchArr[i], 2) == 0): continue
			
			if($Hud/slot1Btn.button_pressed):
				drink_a_name = LoadSingleton.RecipeData[FindDrinkRecipe(SearchArr[i], 2)][0]
			elif($Hud/slot2Btn.button_pressed):
				drink_b_name = LoadSingleton.RecipeData[FindDrinkRecipe(SearchArr[i], 2)][0]
			$"2D/shaker".texture = load("res://resources/Export_Sprites/" + str(LoadSingleton.RecipeData[FindDrinkRecipe(SearchArr[i], 2)][1]))
			$"Hud/drinkName".text = tr(LoadSingleton.RecipeData[FindDrinkRecipe(SearchArr[i], 2)][0])
			isDrink = true
		if(!isDrink):
			$"2D/shaker".texture = load("res://resources/Export_Sprites/glitchbottle_0.png")
			$"Hud/drinkName".text = "#y#bb="
		$"2D/shaker/AnimationPlayer".play("RESET")
	CalcVis(false)

func FindDrinkRecipe(string, mode):
	var findvar
	for i in range (1, 26):
		findvar = LoadSingleton.RecipeData[i][mode].find(string)
		if(findvar == -1 && i == 25):
			return 0
		if(findvar == 0):
			return i

func ServeBtnPressed():
	if(!drink_a_name.is_empty() || !drink_b_name.is_empty()):
		Dialogic.VAR.drink1 = drink_a_name
		Dialogic.VAR.drink2 = drink_b_name
		if($Hud/slot1Btn.button_pressed):
			Dialogic.VAR.drinkflavour = LoadSingleton.RecipeData[FindDrinkRecipe(drink_a_name, 0)][3]
			Dialogic.VAR.drinktype1 = LoadSingleton.RecipeData[FindDrinkRecipe(drink_a_name, 0)][4]
			Dialogic.VAR.drinktype2 = LoadSingleton.RecipeData[FindDrinkRecipe(drink_a_name, 0)][5]
		elif($Hud/slot2Btn.button_pressed):
			Dialogic.VAR.drinkflavour = LoadSingleton.RecipeData[FindDrinkRecipe(drink_b_name, 0)][3]
			Dialogic.VAR.drinktype1 = LoadSingleton.RecipeData[FindDrinkRecipe(drink_b_name, 0)][4]
			Dialogic.VAR.drinktype2 = LoadSingleton.RecipeData[FindDrinkRecipe(drink_b_name, 0)][5]
		print("dialogic var is:%s %s %s %s %s" % [Dialogic.VAR.drink1, Dialogic.VAR.drinkflavour, Dialogic.VAR.KarmoLvl, Dialogic.VAR.drinktype1, Dialogic.VAR.drinktype2])
		Reset()
		Dialogic.paused = false
