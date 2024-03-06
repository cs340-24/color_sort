extends Control

var colors = Array()
var levels = Array()
var levelNum = 1

var numColors
var numBlocks
var numBottles


# Called when the node enters the scene tree for the first time.
func _ready():
	loadGameData()
	playLevels()

func loadGameData():
	# Make a list of the available colors
	var colorFile = FileAccess.open('res://colors.txt', FileAccess.READ)
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
	
	
	# Make a list of each level's data
	var gameFile = FileAccess.open('res://levelData/3colors.txt', FileAccess.READ)
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
		
	print("colors: ",colors)
	print("levels: ", levels)

func playLevels():
	# while !levels.is_empty():
		var level = levels.pop_front()
		play1Level(level)
		levelNum = levelNum + 1

func play1Level(level):
	numBottles = level.pop_front()
	numBlocks = level.pop_front()	
	print("level has ", numBottles, " bottles and ", numBlocks, " blocks ")

	
	# Add the numBlocks color blocks to bottle 1
	var bottle = get_node("./bottles").get_child(0)
	var block = bottle.get_child(0)
	
	for i in numBlocks - 1:
		var newBlock = block.duplicate(15)
		var blockName = "block" + str(i + 2)
		newBlock.set_name(blockName)
		
		bottle.add_child(newBlock)
		bottle.set_owner(get_node("level"))
	
	# duplicate the bottles
	for i in numBottles - 1:
		var newBottle = bottle.duplicate(15)
		var bottleName = "bottle" + str(i + 2)
		newBottle.set_name(bottleName)
		
		$bottles.add_child(newBottle)
		newBottle.set_owner(get_node("level"))
	
	# add the colors
	var blockCounter = 0
	for i in $bottles.get_children():
		for j in i.get_children():
			var rgb = Array()
			rgb = colors[level[blockCounter]]
			blockCounter = blockCounter + 1
			j.set_color(Color(rgb[0], rgb[1], rgb[2], rgb[3]))
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

