extends Node

var currentLevel = 'res://levelData/currentLevel.txt'
# Called when the node enters the scene tree for the first time.
func _ready():
	GameData.save_level_type.connect(save_game)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func save_game(saveType):
	if saveType == 'Complete':
		print("!! GAME COMPLETE !!")
		if FileAccess.file_exists(currentLevel):
			pass
		print("Connection 'delete_save' connected")
	elif saveType == 'Save':
		var file = FileAccess.open(currentLevel, FileAccess.READ_WRITE)
		print("Connection 'save_game' connected")
		print("!! MOVED !!")
	elif saveType == 'Reset':
		var file = FileAccess.open(currentLevel, FileAccess.WRITE_READ)
		print("Connection 'reset_save' connected")
		print("!! RESET !!")
	
