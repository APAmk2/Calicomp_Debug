extends Node

var SaveDate: Array = ["", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""]
var SaveDay: Array = ["", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""]
var SavePlace: Array = ["", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""]

var readData: Array
var musicData: Array
var musicPlaylist: Array = ["", "", "", "", "", "", "", "", "", "", "", ""]
var Money: float = 1
var MoneyInBar: float
var WPapers: int
var HaveWalls: Array
var Day: int = 1
var DayStr: String
var Place: String
var ScanlinesEnabled: bool
var ShopItems: Array = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
var Lang: int

func _ready():
	var file = FileAccess.open("res://resources/musiclist.csv", FileAccess.READ)
	while (!file.eof_reached()):
		musicData.append(file.get_csv_line())
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
		Money = float(readData[6])
		MoneyInBar = float(readData[5])
		WPapers = int(readData[206])
		Day = int(readData[2])
		Place = readData[8]
		DayStr = readData[7]
		ShopItems[1] = readData[171]
		ShopItems[2] = readData[172]
		ShopItems[3] = readData[173]
		ShopItems[4] = readData[175]
		ShopItems[5] = readData[176]
		ShopItems[6] = readData[177]
		ShopItems[7] = readData[178]
		ShopItems[8] = readData[179]
		ShopItems[9] = readData[180]
		ShopItems[10] = readData[181]
		ShopItems[11] = readData[182]
		ShopItems[12] = readData[183]
		ShopItems[13] = readData[184]
		ShopItems[14] = readData[188]
		ShopItems[15] = readData[238]
		ShopItems[16] = readData[186]
		ShopItems[17] = readData[240]
		ShopItems[18] = readData[187]
		ShopItems[19] = readData[185]
		ShopItems[20] = readData[158]

func Save(butNum):
	var file = FileAccess.open("user://saves/Record of Waifu Wars[" + str(butNum) + "].txt", FileAccess.WRITE)
	readData[2] = str(Day)
	readData[5] = str(MoneyInBar)
	readData[6] = str(Money)
	readData[7] = DayStr
	readData[8] = Place
	readData[206] = str(WPapers)
	readData[171] = ShopItems[1]
	readData[172] = ShopItems[2]
	readData[173] = ShopItems[3]
	readData[175] = ShopItems[4]
	readData[176] = ShopItems[5]
	readData[177] = ShopItems[6]
	readData[178] = ShopItems[7]
	readData[179] = ShopItems[8]
	readData[180] = ShopItems[9]
	readData[181] = ShopItems[10]
	readData[182] = ShopItems[11]
	readData[183] = ShopItems[12]
	readData[184] = ShopItems[13]
	readData[188] = ShopItems[14]
	readData[238] = ShopItems[15]
	readData[186] = ShopItems[16]
	readData[240] = ShopItems[17]
	readData[187] = ShopItems[18]
	readData[185] = ShopItems[19]
	readData[158] = ShopItems[20]
	var saveData = PackedStringArray(readData)
	file.store_csv_line(saveData, "\n")  
