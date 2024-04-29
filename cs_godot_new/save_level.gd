extends Node

var currentLevel = 'res://levelData/currentLevel.txt'
var saveVec = {}
var levelVec = {}
var levelStr = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	GameData.save_level_type.connect(save_game)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func save_game(saveType):
	levelStr = ""
	levelVec = {}
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
			file.seek_end(0)
			var level = get_parent().get_child(6)
			## Use gamedata.colors to compare the bottles in numBottles's blocks to RGBA values to set currentBLock = index of checked block
			#print(GameData.colors.values())
			var index = 0
			for x in 4:
				levelVec[index] = GameData.level_data["level_string"][x]
				index = index + 1
			for i in level.get_children():
				for j in i.get_node("Button/Blocks").get_children():
					#print("Color: ", j.get_theme_stylebox("panel").bg_color)
					var colorIndex = GameData.colors.values().find(j.get_theme_stylebox("panel").bg_color)
					##if j.get_theme_stylebox("panel").bg_color in GameData.colors.values():
					if (colorIndex >= 0):
						levelVec[index] = colorIndex
						index = index + 1
			for j in levelVec.size():
				levelStr = levelStr + str(levelVec[j]) + " "
			levelStr = levelStr + '\n'
			print("PRINT STRING: ",levelStr)
			file.store_string(levelStr)
			file.close()
		
			
		else:
			var file = FileAccess.open(currentLevel, FileAccess.WRITE)
			var level = get_parent().get_child(3)
			var index = 0
			for i in GameData.level_data["level_string"].size():
				levelVec[index] = GameData.level_data["level_string"][i]
				index = index+1
			for j in levelVec.size():
				levelStr = levelStr + String(levelVec[j]) + " "
			levelStr = levelStr + '\n'
			print("PRINT STRING: ",levelStr)
			file.store_string(levelStr)
			file.close()
		

	elif saveType == 'Reset':
		var file = FileAccess.open(currentLevel, FileAccess.WRITE_READ)
		print("Connection 'reset_save' connected")
		print("!! RESET !!")
		var level = get_parent().get_child(3)
		var index = 0
		for i in GameData.level_data["level_string"].size():
			levelVec[index] = GameData.level_data["level_string"][i]
			index = index+1
		for j in levelVec.size():
			levelStr = levelStr + String(levelVec[j]) + " "
		levelStr = levelStr + '\n'
		print("PRINT STRING: ",levelStr)
		file.store_string(levelStr)
		file.close()
	
