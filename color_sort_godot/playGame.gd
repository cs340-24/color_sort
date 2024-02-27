extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var levelContent = {}
var numColors
var numSpots
var numBottles
var block = load("res://block.tscn")
var bottle = load("res://tempBottle.tscn")
var botXPos = 200
var blockXPos = 125
var blockYPos = 300
# Called when the node enters the scene tree for the first time.
func _ready():
	read_level()

func read_level():
	var levelFile = FileAccess.open('res://2_1.txt', FileAccess.READ)
	if !levelFile.is_open(): 
		print("ERROR: FILE NOT OPEN")
	var i = 1
	while not levelFile.eof_reached():
		var line = levelFile.get_line()
		levelContent[str(i)] = line
		i += 1
	levelFile.close()
	## TO CHANGE
	numBottles = levelContent["1"]
	numSpots = levelContent["2"]
	print(numBottles)
	i = 0
	var oldY = blockYPos
	var counter = 3
	for j in int(numBottles):
		var newBottle = bottle.instantiate()
		$bottleCont.add_child(newBottle)
		newBottle.position.x  = botXPos
		newBottle.position.y = 200
		newBottle.set_name("bottle")
		blockYPos = oldY
		for k in int(numSpots):
			print("Spawned Block")
			if levelContent[str(counter)] == '1':
				var newBlock = block.instantiate()
				newBlock.set_name("redBlock")
				newBlock.color = Color(1,0,0, 1) 
				# newBlock.rect_position.x = blockXPos
				# newBlock.rect_position.y = blockYPos
				newBottle.get_node("VBoxContainer").add_child(newBlock) 

			if levelContent[str(counter)] == '2':
				var newBlock = block.instantiate()
				newBlock.set_name("greenBlock")
				newBlock.color = Color(0,1,0, 1) 
				# newBlock.rect_position.x = blockXPos
				# newBlock.rect_position.y = blockYPos
				newBottle.get_node("VBoxContainer").add_child(newBlock) 
			if levelContent[str(counter)] == '3':
				var newBlock = block.instantiate()
				newBlock.set_name("blueBlock")
				newBlock.color = Color(0,0,1, 1) 
				# newBlock.rect_position.x = blockXPos
				# newBlock.rect_position.y = blockYPos
				newBottle.get_node("VBoxContainer").add_child(newBlock) 

			if levelContent[str(counter)] == '4':
				var newBlock = block.instantiate()
				newBlock.set_name("purpleBlock")
				newBlock.color = Color(1,0,1,0)
		#		newBottle.newBlock.Area2	D.ColorRect.Color = '#d404ff'
				# newBlock.rect_position.x = blockXPos
				# newBlock.rect_position.y = blockYPos
				newBottle.get_node("VBoxContainer").add_child(newBlock) 

			if levelContent[str(counter)] == '0':
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

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
