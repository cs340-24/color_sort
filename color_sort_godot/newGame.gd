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
	var levelFile = File.new()
	levelFile.open('res://testLevel.txt', File.READ)
	if !levelFile.is_open(): 
		print("ERROR: FILE NOT OPEN")
	var i = 1
	while not levelFile.eof_reached():
		var line = levelFile.get_line()
		levelContent[str(i)] = line
		i += 1
	levelFile.close()
	## TO CHANGE
	# numBottles = levelContent["1"]
	# numBlocks = levelContent["2"]
	numBottles = levelContent["1"]
	numSpots = levelContent["2"]
	numBottles = levelContent["3"]
	print(numBottles)
	i = 0
	var oldY = blockYPos
	var counter = 4
	## var counter = 3
	for j in int(numBottles):
		var newBottle = bottle.instance()
		add_child(newBottle)
		newBottle.rect_position.x  = botXPos
		newBottle.rect_position.y = 200
		newBottle.set_name("bottle")
		blockYPos = oldY
		for k in int(numSpots):
			print("Spawned Block")
			if levelContent[str(counter)] == 'A':
				var newBlock = block.instance()
				newBlock.set_name("redBlock")
				newBlock.color = Color(1,0,0, 1) 
				# newBlock.rect_position.x = blockXPos
				# newBlock.rect_position.y = blockYPos
				newBottle.get_node("VBoxContainer").add_child(newBlock) 

			if levelContent[str(counter)] == 'B':
				var newBlock = block.instance()
				newBlock.set_name("greenBlock")
				newBlock.color = Color(0,1,0, 1) 
				# newBlock.rect_position.x = blockXPos
				# newBlock.rect_position.y = blockYPos
				newBottle.get_node("VBoxContainer").add_child(newBlock) 
			if levelContent[str(counter)] == 'C':
				var newBlock = block.instance()
				newBlock.set_name("blueBlock")
				newBlock.color = Color(0,0,1, 1) 
				# newBlock.rect_position.x = blockXPos
				# newBlock.rect_position.y = blockYPos
				newBottle.get_node("VBoxContainer").add_child(newBlock) 

			if levelContent[str(counter)] == 'D':
				var newBlock = block.instance()
				newBlock.set_name("purpleBlock")
				newBlock.color = Color(1,0,1,0)
		#		newBottle.newBlock.Area2	D.ColorRect.Color = '#d404ff'
				# newBlock.rect_position.x = blockXPos
				# newBlock.rect_position.y = blockYPos
				newBottle.get_node("VBoxContainer").add_child(newBlock) 

			if levelContent[str(counter)] == '-':
				var newBlock = block.instance()
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
