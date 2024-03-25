extends Node

var game_filename = "res://levelData/1per.txt"
var color_filename = "res://colors.txt"
var bottles_scene = preload("res://level.tscn")

signal reset_level

var max_colors  # number of colors in the color file

@export var level_data = {}  # data for one level
@export var levels = []      # each element is an array of data for 1 level
@export var colors = {}      # ckey: name of color
							 # val: Color(r,g,b,a)
var top_color                # top color in a bottle
var empty_color              # color used for empty blocks
var num_blocks               # number of blocks per bottle
var num_colors               # number of colors in a level
var bottles_completed        # number of bottles completed so far in a level
var bottles_pressed          # how many bottles have been pressed consecutively
var bottle_from              # bottle moving color from
var bottle_to                # bottle moving color to
var level_pos = Vector2(50, 180)    # position of the grid on the game screen
var level_size = Vector2(620, 1050) # size of the grid on the game screen


func _ready():
	load_game_data()


func load_game_data():
	# Make a list of the available colors
	var color_file = FileAccess.open(color_filename, FileAccess.READ)
	if color_file != null:
		while color_file.get_position() < color_file.get_length():
			# rgba[0] is the name of the color. the next 4 vals are the rgba values of the color
			var rgba = color_file.get_line().split(" ")
			# add the color to the list
			colors[rgba[0]] = Color(float(rgba[1]), float(rgba[2]), float(rgba[3]), float(rgba[4]))
			
		color_file.close()
		empty_color = colors["empty"]
		# -1 to subtract empty color 
		max_colors = colors.size() - 1
	else:
		print("Error: Could not load color file.")
		return false
	
	
	# Make a list of each level's data
	var game_file = FileAccess.open(game_filename, FileAccess.READ)
	if game_file != null: 
		while game_file.get_position() < game_file.get_length():
			var numStr = game_file.get_line().split(" ")
			
			# convert to floats
			var nums = []
			for num in numStr:
				nums.push_back(float(num))

			level_data = {
				"rows" : nums[0], 
				"cols" : nums[1], 
				"num_colors" : 0,
				"num_bottles" : nums[2], 
				"num_blocks" : nums[3], 
			}
			
			# add number of colors 
			if level_data["num_bottles"] > 4:
				level_data["num_colors"] = level_data["num_bottles"] - 2
			else:
				level_data["num_colors"] = level_data["num_bottles"] - 1
			
			# cut off first 4 values to make a vector of the color blocks' colors
			nums = nums.slice(4)
			var block_colors = []
			# convert the ints to corresponding its Color
			# the index of the color in the dictionary corresponds to the color val in 
			# the vector. so nums[i] = 3 corresponds to colors.values()[3]
			for num in nums:
				block_colors.push_back(colors.values()[num])
			# add the block's colors to the dictionary
			level_data["color_vals"] = block_colors
			levels.push_back(level_data)
		game_file.close()
	else: 
		print("Error: Could not load level data.")
		return false




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
