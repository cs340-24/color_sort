extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var levelContent = {}
var currLevel = {}
var numColors
var numSpots
var numBottles
var block = load("res://block.tscn")
var bottle = load("res://tempBottle.tscn")
var botXPos = 200
var blockXPos = 125
var blockYPos = 300
var levelNum = 1
var levelVec = {}
var moveBlockVec = {}
var currLevelFile
var levelGenText = 'res://levelData/3colors.txt'
# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("UpperButtons/ChangeDifficulty/Difficulty").hide()
	read_level()


func read_level():
	var levelFile = FileAccess.open(levelGenText, FileAccess.READ)
	if !levelFile.is_open(): 
		print("ERROR: FILE NOT OPEN")
	var i = 1
	while not levelFile.eof_reached():
		var line = levelFile.get_line()
		levelContent[str(i)] = line
		i += 1
	levelFile.close()
	generate_level(levelContent, levelNum)
	## TO CHANGE

func generate_level(levelContent, levelNum):
	for n in $bottleCont.get_children():
		$bottleCont.remove_child(n)
		n.queue_free()
	currLevel = {}
	currLevel = levelContent[str(levelNum)].split(" ", false, 30)
	numBottles = currLevel[0]
	numSpots = currLevel[1]
	get_node('bottleCont').columns = int(numBottles) / 2 
	print(numBottles)
	var i = 0
	var oldY = blockYPos
	var counter = 2
	for j in int(numBottles):
		var newBottle = bottle.instantiate()
		$bottleCont.add_child(newBottle)
		newBottle.position.x  = botXPos
		newBottle.position.y = 200
		newBottle.set_name("bottle")
		blockYPos = oldY
		for k in int(numSpots):
			print("Spawned Block")
			if currLevel[counter] == '1':
				var newBlock = block.instantiate()
				newBlock.set_name("redBlock")
				newBlock.color = Color(1,0,0, 1) 
				# newBlock.rect_position.x = blockXPos
				# newBlock.rect_position.y = blockYPos
				newBottle.get_node("VBoxContainer").add_child(newBlock) 

			if currLevel[counter] == '2':
				var newBlock = block.instantiate()
				newBlock.set_name("greenBlock")
				newBlock.color = Color(0,1,0, 1) 
				# newBlock.rect_position.x = blockXPos
				# newBlock.rect_position.y = blockYPos
				newBottle.get_node("VBoxContainer").add_child(newBlock) 
			if currLevel[counter] == '3':
				var newBlock = block.instantiate()
				newBlock.set_name("blueBlock")
				newBlock.color = Color(0,0,1, 1) 
				# newBlock.rect_position.x = blockXPos
				# newBlock.rect_position.y = blockYPos
				newBottle.get_node("VBoxContainer").add_child(newBlock) 

			if currLevel[counter] == '4':
				var newBlock = block.instantiate()
				newBlock.set_name("purpleBlock")
				newBlock.color = Color(1,0,1,0)
		#		newBottle.newBlock.Area2	D.ColorRect.Color = '#d404ff'
				# newBlock.rect_position.x = blockXPos
				# newBlock.rect_position.y = blockYPos
				newBottle.get_node("VBoxContainer").add_child(newBlock) 

			if currLevel[counter] == '0':
				var newBlock = block.instantiate()
				newBlock.set_name("nullBlock")
				newBlock.color = Color(0,0,0,0) 
				#newBottle.get_node("nullBlock"+str(counter-4)).Area2D.ColorRect.Color = '#fffff'
				# newBlock.rect_position.x = blockXPos
				# newBlock.rect_position.y = blockYPos
				newBottle.get_node("VBoxContainer").add_child(newBlock) 


			blockYPos -= 70
			blockXPos += 150
			counter += 1

		botXPos += 250
	print("Level Generated")

func select_block():
	pass

func move_block():
	pass

func save_level(levelVec):
	pass

func write_to_file(currLevelFile, numBottles, numSpots):
	pass


# Debug button added in order to test level switching
func _on_next_level_pressed():
	levelNum += 1
	generate_level(levelContent,levelNum)

func _process(delta):
	# if $tempBottle.hasBeenPressed == true:
	# 	$tempBottle.get_node("block")
	pass



func _on_reset_level_pressed():
	generate_level(levelContent, levelNum)
	print("Level Reset")


func _on_change_difficulty_pressed():
	get_node("UpperButtons/ChangeDifficulty/Difficulty").show()

func _on_three_color_pressed():
	print("Three Color!")
	levelGenText = 'res://levelData/3colors.txt'
	levelNum = 1
	get_node("UpperButtons/ChangeDifficulty/Difficulty").hide()
	read_level()

func _on_four_color_pressed():
	print("Four Color!")
	levelGenText = 'res://levelData/4colors.txt'
	levelNum = 1	
	get_node("UpperButtons/ChangeDifficulty/Difficulty").hide()
	read_level()

func _on_five_color_pressed():
	print("Five Color!")
	levelGenText = 'res://levelData/5colors.txt'
	levelNum = 1	
	get_node("UpperButtons/ChangeDifficulty/Difficulty").hide()
	read_level()

func _on_cancel_pressed():
	print("Cancel!")
	get_node("UpperButtons/ChangeDifficulty/Difficulty").hide()
