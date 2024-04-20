extends Node

var currentLevel = 'res://levelData/currentLevel.txt'
var saveVec = {}
var levelVec = {}


# Called when the node enters the scene tree for the first time.
func _ready():
	GameData.save_level_type.connect(save_game)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func save_game(saveType):
	if saveType == 'Complete':
		if FileAccess.file_exists(currentLevel):
			var dir = DirAccess.open('res://levelData')
			dir.remove('currentLevel.txt')
		levelVec = {}
		print("Connection 'delete_save' connected")
		print("!! GAME COMPLETE !!")
		
	elif saveType == 'Save':
		print("Connection 'save_game' connected")
		print("!! MOVED !!")
		if FileAccess.file_exists(currentLevel):
			var file = FileAccess.open(currentLevel, FileAccess.READ_WRITE)
			file.seek_end()
			var level = get_node("../Level")
			## Use gamedata.colors to compare the bottles in numBottles's blocks to RGBA values to set currentBLock = index of checked block
			print(GameData.colors)
			for i in level.get_children():
				for j in i.get_node("Blocks").get_children():
					print(j.color)
				#level.get_child("Bottle")
				#for j in level.bottle[i]:
					print("TEST")
			
		else:
			var file = FileAccess.open(currentLevel, FileAccess.WRITE)
			var Level = get_node("../Level")
			var index = 0
			var levelStr = ""
			for i in GameData.level_data["level_string"].size():
				levelVec[index] = GameData.level_data["level_string"][i]
				index = index+1
			for j in levelVec.size():
				levelStr = levelStr + String(levelVec[j]) + " "
			print("PRINT STRING: ",levelStr)
			file.store_string(levelStr)
			file.close()
		

	elif saveType == 'Reset':
		var file = FileAccess.open(currentLevel, FileAccess.WRITE_READ)
		print("Connection 'reset_save' connected")
		print("!! RESET !!")
		var Level = get_node("../Level")
		var index = 0
		var levelStr = ""
		for i in GameData.level_data["level_string"].size():
			levelVec[index] = GameData.level_data["level_string"][i]
			index = index+1
		for j in levelVec.size():
			levelStr = levelStr + String(levelVec[j]) + " "
		print("PRINT STRING: ",levelStr)
		file.store_string(levelStr)
		file.close()
	
