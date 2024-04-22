extends Node


var color_filename = "res://colors.txt"
var bottles_scene = preload("res://level.tscn")
var game_screen = preload("res://game.tscn")
var win_msg = preload("res://win_msg.tscn")

signal reset_level
signal make_move
signal level_complete
signal start
signal load_game
signal game_loaded
signal game_complete
signal sound_control
signal volume_control
signal save_level_type
signal help
signal back_to_game
signal undo_move
signal time_challenge_mode
signal reset_time
var max_colors  # number of colors in the color file

var move_array = []  # keeps track of moves
var level_data = {}  # data for one level
var levels = []      # each element is an array of data for 1 level
var colors = {}      # ckey: name of color
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
	load_colors()
	
	# eventually have a function for choosing game file?

func load_colors():
	# Make a list of the available colors
	var color_file = FileAccess.open(color_filename, FileAccess.READ)
	if color_file != null:
		while color_file.get_position() < color_file.get_length():
			# rgba[0] is the name of the color. the next 4 vals are the rgba values of the color
			var rgba = color_file.get_line().split(" ")
			# add the color to the list
			colors[rgba[0]] = Color(rgba[1])
			
		color_file.close()
		empty_color = colors["empty"]
		# -1 to subtract empty color 
		max_colors = colors.size() - 1
	else:
		print("Error: Could not load color file.")
		return false
	

