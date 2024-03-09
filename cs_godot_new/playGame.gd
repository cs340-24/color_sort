extends Control

var levels = Array() # each element is an array of data for 1 level
var colors = Array() # list of rgba values for the blocks. index corresponds to
					 # the number in the level data file

var emptyColor = Color(0, 0, 0, 1)
var numColors        # number of colors in the level
var numBlocks        # number of blocks per bottle in the level
var numBottles       # number of bottles in the level

var bottlesCompleted 
var bottlesPressed = 0
@onready var bottleFrom = get_node("bottles/bottle1")
@onready var bottleTo = get_node("bottles/bottle1")

var gameFilename = "res://levelData/1per.txt"
var colorFilename = "res://colors.txt"
var bottlesScene = preload("res://bottles.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	loadGameData()
	#bottlesCompleted = 0
	#loadLevelData(levels[2])

	for level in levels:
		bottlesCompleted = 0
		loadLevelData(level)
		await get_tree().create_timer(2).timeout
		
		var bottles = get_node("bottles")
		var gridSize = bottles.size
		var pos = bottles.get_begin()
		
		bottles.free()
		bottles = bottlesScene.instantiate()
		bottles.set_position(pos)
		bottles.set_size(gridSize)
		add_child(bottles)

		


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

			

# Duplicate nodes to create numBottles bottles with numBlocks blocks each.
# Set the color values for the blocks and spacing around the bottles
func loadLevelData(level):
	var bottlesGrid = get_node("bottles")
	var bottle = bottlesGrid.get_child(0)
	var blocks = bottle.get_child(0)
	var block = blocks.get_child(0)
	
	# for naming nodes
	var nodeName
	
	# set columns and grid spacing
	var rows = level.pop_front()
	var cols = level.pop_front()
	bottlesGrid.columns = cols
	
	# adjust bottle separation for 2 rows
	if rows == 2:
		bottlesGrid.add_theme_constant_override("h_separation", 100)
		if cols != 4:
			bottlesGrid.add_theme_constant_override("v_separation", 200)
			
	
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
		blocks.add_child(newBlock)
		block.set_owner(get_node("."))
		# bottle.set_owner(get_node("."))
	
	# duplicate the remaining bottles by duplicating the aspect ratio node
	for i in numBottles - 1:
		var newBottle = bottle.duplicate(15)
		nodeName = "bottle" + str(i + 2) 
		newBottle.set_name(nodeName)
		bottlesGrid.add_child(newBottle)
		newBottle.set_owner(get_node("."))


	
	
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

	# set bottle metadata
	for i in bottlesGrid.get_children():
		# topColor
		var topColor = i.get_child(0).get_child(0).get_color()
		i.set_meta("isComplete", false)
		i.set_meta("topColor", topColor)
		
		# if top color is the empty color, then this bottle is empty
		if topColor == emptyColor:
			i.set_meta("emptyBlocks", numBlocks)
			i.set_meta("topColorBlocks", 0)
		# count how many consecutive blocks of top color there are
		else:
			var topColorBlocks = 0
			for j in i.get_child(0).get_children():
				if j.get_color() == topColor:
					topColorBlocks = topColorBlocks + 1
				else:
					break
			i.set_meta("topColorBlocks", topColorBlocks)
			if topColorBlocks == numBlocks:
				i.set_meta("isComplete", true)
				bottlesCompleted = bottlesCompleted + 1
			else:
				i.set_meta("isComplete", false)
				
	# check the meta data
	for i in bottlesGrid.get_children():
		print(i.get_name(), ":  color = ", i.get_meta("topColor"), "  top color blocks = ", i.get_meta("topColorBlocks"), "  number of empty blocks: ", i.get_meta("emptyBlocks"))
	
	return true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# while bottlesCompleted != numColors:
	pass

