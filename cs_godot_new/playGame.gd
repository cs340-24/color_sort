extends Control

var levels = Array() # each element is an array of data for 1 level
var colors = Array() # list of rgba values for the blocks. index corresponds to
					 # the number in the level data file

var levelNum         # number of the level player is on
var levelComplete    # true if all the bottles are sorted

var numColors        # number of colors in the level
var numBlocks        # number of blocks per bottle in the level
var numBottles       # number of bottles in the level

var marginTB         #margin above/below bottles
var marginLR         #margin to the left/right of the bottles

var gameFilename = "res://levelData/1per.txt"
var colorFilename = "res://colors.txt"


# Called when the node enters the scene tree for the first time.
func _ready():
	loadGameData()
	playGame()


# Open file with list of colors, parse the rgba values and add to colors[]
# Open file with game data. Parse the input into an array and put the array in
# levels[]
func loadGameData():
	# Make a list of the available colors
	var colorFile = FileAccess.open(colorFilename, FileAccess.READ)
	if colorFile != null:
		while colorFile.eof_reached() == false:
			var color = colorFile.get_line()
			var rgbStr = color.split(" ")
			var rgb = Array()
			for num in rgbStr:
				rgb.push_back(float(num))
			colors.push_back(rgb)
		colorFile.close()
	else:
		print("Error: Could not load color file.")
		return false
	
	# Make a list of each level's data
	var gameFile = FileAccess.open(gameFilename, FileAccess.READ)
	if gameFile != null: 
		while gameFile.eof_reached() == false:
			var line = gameFile.get_line()
			
			# skip lines that don't have enough vals
			if line.length() > 8:
				var numsStr = line.split(" ")
				
				var numsInt = Array()
				for num in numsStr:
					numsInt.push_back(int(num))
				levels.push_back(numsInt)
		gameFile.close()
	else: 
		print("Error: Could not load level data.")
		return false

# While there are levels left in the list to play, play level
func playGame():
	levelNum = 1
	levelComplete = false
	loadLevelData(levels[10])
	# while !levels.is_empty():
		# var level = levels.pop_front()

			# print("Level loaded successfully")
			# playLevel()
			# clearLevel()
			# levelNum = levelNum + 1
			

# Duplicate nodes to create numBottles bottles with numBlocks blocks each.
# Set the color values for the blocks and spacing around the bottles
func loadLevelData(level):
	var bottlesGrid = get_node("bottles")
	var bottle = get_node("./bottles/bottle1/blocks")
	var block = bottle.get_child(0)
	
	# for naming nodes
	var nodeName
	
	# set columns and grid spacing
	var bottleMargin = get_node("bottles/bottle1")
	var rows = level.pop_front()
	var cols = level.pop_front()
	bottlesGrid.columns = cols
	setBottleSpacing(bottleMargin, rows, cols)
	
	# get numBottles, numBlocks, and numColors
	# pop these off so level[0] will be the color val of the first block. 
	# makes setting the colors easier 
	numBottles = level.pop_front()
	numBlocks = level.pop_front()	
	
	# subtract the empty bottles to get the number of colors in the level
	if numBottles > 4:
		numColors = numBottles - 2
	else:
		numColors = numBottles - 1
	print("level has ", numBottles, " bottles, ", numBlocks, " blocks, and ", numColors, " colors")


	# Add remaining color blocks to first bottle
	for i in numBlocks - 1:
		var newBlock = block.duplicate(15)
		nodeName = "block" + str(i + 2)
		newBlock.set_name(nodeName)
		
		# Need to set owner to the root node of the scene for everything to 
		# work correctly
		bottle.add_child(newBlock)
		bottle.set_owner(get_node("level"))
	
	# duplicate the remaining bottles by duplicating its oute margin node
	for i in numBottles - 1:	
		var newBottleMargin = bottleMargin.duplicate(15)
		nodeName = "bottle" + str(i + 2) 
		newBottleMargin.set_name(nodeName)
		bottlesGrid.add_child(newBottleMargin)
		newBottleMargin.set_owner(get_node("level"))

	
	# iterate through the color blocks, setting their rgba vals.
	# the value at level[index] corresponds to an index in the colors array. 
	# so if level[2] == 1, then the color will be at colors[1].
	var blockCounter = 0 
	# iterate through the bottles
	for i in bottlesGrid.get_children():
		# iterate through the bottle's blocks
		for j in i.get_child(0).get_children():
			var rgba = Array()
			rgba = colors[level[blockCounter]]
			blockCounter = blockCounter + 1
			j.set_color(Color(rgba[0], rgba[1], rgba[2], rgba[3]))
	
	return true


# figure out how much padding to put above and below each bottle
func setBottleSpacing(bottleMargin, rows, cols):
	if cols == 2:
		marginLR = 100
		marginTB = 60
	elif cols == 3:
		if rows == 1:
			marginLR = 40
			marginTB = 250
		elif rows == 2:
			marginLR = 50
			marginTB = 60
		else:		
			marginLR = 65
			marginTB = 40
	elif cols == 4:
		if rows == 2:
			marginTB = 60
			marginLR = 30
		else:		
			marginTB = 40
			marginLR = 40
	elif cols == 5:
		marginLR = 25
		if rows == 2:
			marginTB = 100
		else:
			marginTB = 40	
	bottleMargin.add_theme_constant_override("margin_left", marginLR)
	bottleMargin.add_theme_constant_override("margin_right", marginLR)
	bottleMargin.add_theme_constant_override("margin_top", marginTB)
	bottleMargin.add_theme_constant_override("margin_bottom", marginTB)	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

