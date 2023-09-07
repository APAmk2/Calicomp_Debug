extends Node

var read: Array
var money: float = 1
var money_in_bar: float
var walls: int
var walls_buy: Array
var day: int = 1
var day_str: String
var stage: String
var scanlines: int
var shop_items: Array = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

func _load(but_num):
	var file = FileAccess.open("user://saves/Record of Waifu Wars[" + str(but_num) + "].txt", FileAccess.READ)
	print("user://saves/Record of Waifu Wars[" + str(but_num) + "].txt")
	if(file != null):
		read.clear()
		print("Everything fine, loading Save.")
		while(!file.eof_reached()):
			var check = file.get_line()
#			if(check.length() == 1): Strange bug, seems saves created by CALICOMP DEBUG cant be loaded after, then, idk how i fucking need to check invalid last string to avoid new strs creation
#				print("Something went wrong, loading was interrupted! Iterations made: " + str(sheeotchyk))
#				pass
#			else: 
			read.append(check)
		money = float(read[6])
		money_in_bar = float(read[5])
		walls = int(read[206])
		day = int(read[2])
		stage = read[8]
		day_str = read[7]
		shop_items[1] = read[171]
		shop_items[2] = read[172]
		shop_items[3] = read[173]
		shop_items[4] = read[175]
		shop_items[5] = read[176]
		shop_items[6] = read[177]
		shop_items[7] = read[178]
		shop_items[8] = read[179]
		shop_items[9] = read[180]
		shop_items[10] = read[181]
		shop_items[11] = read[182]
		shop_items[12] = read[183]
		shop_items[13] = read[184]
		shop_items[14] = read[188]
		shop_items[15] = read[238]
		shop_items[16] = read[186]
		shop_items[17] = read[240]
		shop_items[18] = read[187]
		shop_items[19] = read[185]
		shop_items[20] = read[158]
		file = null
		return true
	else:
		print("Something went wrong, can't load Save!")
		return false
func _save(but_num):
	var file = FileAccess.open("user://saves/Record of Waifu Wars[" + str(but_num) + "].txt", FileAccess.WRITE)
	read[2] = str(day)
	read[5] = str(money_in_bar)
	read[6] = str(money)
	read[7] = day_str
	read[8] = stage
	read[206] = str(walls)
	read[171] = shop_items[1]
	read[172] = shop_items[2]
	read[173] = shop_items[3]
	read[175] = shop_items[4]
	read[176] = shop_items[5]
	read[177] = shop_items[6]
	read[178] = shop_items[7]
	read[179] = shop_items[8]
	read[180] = shop_items[9]
	read[181] = shop_items[10]
	read[182] = shop_items[11]
	read[183] = shop_items[12]
	read[184] = shop_items[13]
	read[188] = shop_items[14]
	read[238] = shop_items[15]
	read[186] = shop_items[16]
	read[240] = shop_items[17]
	read[187] = shop_items[18]
	read[185] = shop_items[19]
	read[158] = shop_items[20]
	var save = PackedStringArray(read)
	file.store_csv_line(save, "\n")  
