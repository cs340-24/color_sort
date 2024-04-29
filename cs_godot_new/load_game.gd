extends Control

var welcome
var game
var game_filename = "res://levelData/demo.txt"
var welcome_screen = preload("res://welcome_screen.tscn")
var help_screen = preload("res://help.tscn")
var help_var

# Called when the node enters the scene tree for the first time.
func _ready():
	load_game()

func load_game():
		# load the welcome screen
	load_welcome()
	GameData.game_complete.connect(load_next_game)
	GameData.help.connect(load_help)
	GameData.back_to_game.connect(clear_help_screen)

	# wait till user presses "play game" to start the game
	# when they do, clear the welcome screen 
	GameData.start.connect(clear_welcome_screen)
	await GameData.start
	
	# load the game scene
	game = GameData.game_screen.instantiate()
	game.set_name("Game")
	add_child(game)
	game.set_owner(get_node("."))
	
	# load the game data
	load_game_data()
	await GameData.game_complete

func _deferred_load_next_game():
	self.modulate = Color(1,1,1,1)
	game.free()
	load_game()
	

func load_next_game():
	call_deferred("_deferred_load_next_game")


func load_welcome():
	welcome = welcome_screen.instantiate()
	welcome.set_name("WelcomeScreen")
	add_child(welcome)
	welcome.set_owner(get_node("."))

# need to defer to make sure it stops signaling before you try to free it
# so it doesn't crash the game
func _deferred_clear_welcome_screen():
	#GameData.popup.show()
	welcome.free()

func clear_welcome_screen():
	call_deferred("_deferred_clear_welcome_screen")

func load_help():
	help_var = help_screen.instantiate()
	help_var.set_name("HelpScreen")
	get_tree().root.add_child(help_var)
	help_var.set_owner(get_tree().root)

func clear_help_screen():
	call_deferred("_deffered_clear_help_screen", help_var)

func _deffered_clear_help_screen(help_var):
	help_var.free()

func load_game_data():
	
	# Make a list of each level's data
	var game_file = FileAccess.open(game_filename, FileAccess.READ)
	if game_file != null: 
		while game_file.get_position() < game_file.get_length():
			var numStr = game_file.get_line().split(" ")
						
			# convert to floats
			var nums = []
			for num in numStr:
				nums.push_back(float(num))

			GameData.level_data = {
				"rows" : nums[0], 
				"cols" : nums[1], 
				"num_colors" : 0,
				"num_bottles" : nums[2], 
				"num_blocks" : nums[3],
				"level_string" : numStr,
				"hidden" : false
			}
			
			if numStr[numStr.size() - 1] == "H":
				GameData.level_data["hidden"] = true
				numStr.remove_at(numStr.size() - 1);
			
			# add number of colors 
			if GameData.level_data["num_bottles"] > 4:
				GameData.level_data["num_colors"] = GameData.level_data["num_bottles"] - 2
			else:
				GameData.level_data["num_colors"] = GameData.level_data["num_bottles"] - 1
			
			# cut off first 4 values to make a vector of the color blocks' colors
			nums = nums.slice(4)
			var block_colors = []
			# convert the ints to corresponding its Color
			# the index of the color in the dictionary corresponds to the color val in 
			# the vector. so nums[i] = 3 corresponds to colors.values()[3]
			for num in nums:
				block_colors.push_back(GameData.colors.values()[num])
			# add the block's colors to the dictionary
			GameData.level_data["color_vals"] = block_colors
			GameData.levels.push_back(GameData.level_data)
		game_file.close()
		
		GameData.game_loaded.emit()
	else: 
		print("Error: Could not load level data.")
		return false


