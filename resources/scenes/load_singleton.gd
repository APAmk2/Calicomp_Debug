extends Node

var SaveDate: Array = ["", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""]
var SaveDay: Array = ["", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""]
var SavePlace: Array = ["", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""]

var readData: Array
var musicData: Array
var RecipeData: Array
var ScanlinesEnabled: bool
var Lang: int

func _ready():
	var file = FileAccess.open("res://resources/musiclist.csv", FileAccess.READ)
	while (!file.eof_reached()):
		musicData.append(file.get_csv_line())
	file.close()
	file = FileAccess.open("res://resources/drinktionary.csv", FileAccess.READ)
	while (!file.eof_reached()):
		RecipeData.append(file.get_csv_line())
	file.close()

func Load(butNum, LoadAll):
	var file = FileAccess.open("user://saves/Record of Waifu Wars[" + str(butNum) + "].txt", FileAccess.READ)
	print("user://saves/Record of Waifu Wars[" + str(butNum) + "].txt")
	if(file != null):
		readData.clear()
		print("Everything fine, loading Save.")
		while(!file.eof_reached()):
			var check = file.get_line()
#			if(check.length() == 1): Strange bug, seems saves created by CALICOMP DEBUG cant be loaded after, then, idk how i fucking need to check invalid last string to avoid new strs creation
#				print("Something went wrong, loading was interrupted! Iterations made: " + str(loadCounter))
#				pass
#			else: 
			readData.append(check)
		SaveDate[butNum - 1] = readData[0]
		SaveDay[butNum - 1] = readData[2]
		SavePlace[butNum - 1] = readData[8]
		if(LoadAll):
			LoadVars()
		file = null
		return true
	else:
		print("Something went wrong, can't load Save!")
		return false

func LoadVars():
		GlobalVars.cur_day = int(readData[2])
		GlobalVars.barscore = float(readData[5])
		GlobalVars.jillwallet = float(readData[6])
		GlobalVars.datestring = readData[7]
		GlobalVars.dayphase = readData[8]
		GlobalVars.shopitems[20] = readData[158]
		GlobalVars.shopitems[1] = readData[171]
		GlobalVars.shopitems[2] = readData[172]
		GlobalVars.shopitems[3] = readData[173]
		GlobalVars.shopitems[4] = readData[175]
		GlobalVars.shopitems[5] = readData[176]
		GlobalVars.shopitems[6] = readData[177]
		GlobalVars.shopitems[7] = readData[178]
		GlobalVars.shopitems[8] = readData[179]
		GlobalVars.shopitems[9] = readData[180]
		GlobalVars.shopitems[10] = readData[181]
		GlobalVars.shopitems[11] = readData[182]
		GlobalVars.shopitems[12] = readData[183]
		GlobalVars.shopitems[13] = readData[184]
		GlobalVars.shopitems[19] = readData[185]
		GlobalVars.shopitems[16] = readData[186]
		GlobalVars.shopitems[18] = readData[187]
		GlobalVars.shopitems[14] = readData[188]
		GlobalVars.wallstype = int(readData[206])
		for i in range (0, 12):
			GlobalVars.songnames[i] = readData[219 + i]
		GlobalVars.shopitems[15] = readData[238]
		GlobalVars.shopitems[17] = readData[240]

func Save(butNum):
	var file = FileAccess.open("user://saves/Record of Waifu Wars[" + str(butNum) + "].txt", FileAccess.WRITE)
	readData[2] = str(GlobalVars.cur_day)
	readData[5] = str(GlobalVars.barscore)
	readData[6] = str(GlobalVars.jillwallet)
	readData[7] = GlobalVars.datestring
	readData[8] = GlobalVars.dayphase
	readData[206] = str(GlobalVars.wallstype)
	readData[171] = GlobalVars.shopitems[1]
	readData[172] = GlobalVars.shopitems[2]
	readData[173] = GlobalVars.shopitems[3]
	readData[175] = GlobalVars.shopitems[4]
	readData[176] = GlobalVars.shopitems[5]
	readData[177] = GlobalVars.shopitems[6]
	readData[178] = GlobalVars.shopitems[7]
	readData[179] = GlobalVars.shopitems[8]
	readData[180] = GlobalVars.shopitems[9]
	readData[181] = GlobalVars.shopitems[10]
	readData[182] = GlobalVars.shopitems[11]
	readData[183] = GlobalVars.shopitems[12]
	readData[184] = GlobalVars.shopitems[13]
	readData[188] = GlobalVars.shopitems[14]
	readData[238] = GlobalVars.shopitems[15]
	readData[186] = GlobalVars.shopitems[16]
	readData[240] = GlobalVars.shopitems[17]
	readData[187] = GlobalVars.shopitems[18]
	readData[185] = GlobalVars.shopitems[19]
	readData[158] = GlobalVars.shopitems[20]
	for i in range (0, 12):
		readData[219 + i] = GlobalVars.songnames[i] 
	var saveData = PackedStringArray(readData)
	file.store_csv_line(saveData, "\n")  
