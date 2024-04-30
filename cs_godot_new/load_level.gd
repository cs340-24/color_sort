extends Node

var level
var bottle 
var blocks
var block 
var button

var help_screen = preload("res://help.tscn")
var help_var
var con

# Called when the node enters the scene tree for the first time.
func _ready():
	GameData.reset_level.connect(reset)
	GameData.help.connect(display_help)
	GameData.back_to_game.connect(clear_help_screen)
	await GameData.game_loaded
	GameData.moves = 0
	level = get_child(6)
	$Background_music.play()
	
	for level_data in GameData.levels:
		GameData.level_data = level_data 
		
		if GameData.level_data["hidden"] == true:
			GameData.hide_colors = true
		else:
			GameData.hide_colors = false
		
		# bottles_completed and bottles_pressed need to be 0 to start
		GameData.bottles_completed = 0
		GameData.bottles_pressed = 0

		
		# load the level's data
		load_level_data(level_data)
		
		
		GameData.level_complete.connect(clear_level)
		await GameData.level_complete
		
		# load the level scene
		level = GameData.bottles_scene.instantiate()
		level.set_name("Level")
		add_child(level)
		level.set_owner(get_node("."))
		
		
	GameData.game_complete.emit()





# Duplicate nodes to create numBottles bottles with numBlocks blocks each.
# Set the color values for the blocks and spacing around the bottles
func load_level_data(level_data):
	bottle = level.get_child(0)
	button = bottle.get_child(0)
	blocks = bottle.get_child(0).get_child(0)
	block = blocks.get_child(0)
	
	# for naming nodes
	var node_name
	
	# set columns and grid spacing
	level.columns = level_data["cols"]
	GameData.num_blocks = level_data["num_blocks"]
	GameData.num_colors = level_data["num_colors"]
	
	# Adjust the grid spacing
	if (level_data["rows"] == 2):
		if level_data["cols"] == 4:
			level.add_theme_constant_override("h_separation", 400)
			level.add_theme_constant_override("v_separation", 800)			
		else:
			level.add_theme_constant_override("h_separation", 200)
			level.add_theme_constant_override("v_separation", 1500)			
	elif (level_data["rows"] == 3):
		if level_data["cols"] == 3:
			level.add_theme_constant_override("h_separation", 200)
			level.add_theme_constant_override("v_separation", 400)		
		else:
			level.add_theme_constant_override("h_separation", 350)
			level.add_theme_constant_override("v_separation", 550)		


	# duplicate bottle1's color blocks. have to do this before duplicating the bottles
	# or there will be problems with setting the metadata later
	for i in level_data["num_blocks"] - 1:
		var new_block = block.duplicate(15)
		node_name = "Block" + str(i + 2)
		new_block.set_name(node_name)
		blocks.add_child(new_block)
		new_block.set_owner(get_node("."))

	# duplicate the bottles by duplicating the aspect ratio node
	for i in level_data["num_bottles"] - 1:
		var new_bottle = bottle.duplicate(15)
		node_name = "Bottle" + str(i + 2) 
		new_bottle.set_name(node_name)
		level.add_child(new_bottle)
		new_bottle.set_owner(get_node("."))
	
	set_colors(level_data)

						
	return true




# iterate through the color blocks and set their colors
# set bottle metadata (top_color, top_blocks, empty_blocks
func set_colors(level_data):
	var color
	var block_index = 0
	for i in level.get_children():
		# set the block's colors
		for j in i.get_child(0).get_child(0).get_children():
			color = level_data["color_vals"][block_index]
			

			var block_style = StyleBoxFlat.new()
			block_style.border_color = Color("3f3f3f")
			block_style.border_blend = true
			block_style.border_width_left = 10
			block_style.border_width_right = 10
			
			# round off the corners if it's the bottom block
			if int(block_index) % int(GameData.num_blocks) - 3 == 0:
				block_style.corner_radius_bottom_right = 130
				block_style.corner_radius_bottom_left = 130
				block_style.corner_detail = 10
				block_style.border_width_bottom = 10
				
				
			block_index = block_index + 1
			
			# set top color
			if j.get_name() == "Block1":
				block_style.set_bg_color(color)
				GameData.top_color = color
				i.set_meta("top_color", GameData.top_color)
				block_style.corner_radius_top_right = 40
				block_style.corner_radius_top_left = 40
				# if top color is empty color, this is an empty bottle
				if GameData.top_color == GameData.empty_color:
					i.set_meta("empty_blocks", level_data["num_blocks"])
					i.set_meta("is_complete", false)
			else: 
				#if GameData.top_color != GameData.empty_color:
				if GameData.hide_colors == true && GameData.top_color != GameData.empty_color:
					block_style.set_bg_color("000000")
					j.set_meta("hidden", true)
				else: 
					block_style.set_bg_color(color)
					j.set_meta("hidden", false)
				#else:
					#block_style.set_bg_color(color)
					#j.set_meta("hidden", false)
				
			j.add_theme_stylebox_override("panel", block_style)
			j.set_meta("color", color)		
			
			
	# if bottle isn't empty, need to see how many consecutive blocks of top_color there are
	for i in level.get_children():
	
		# if bottle isn't empty
		if i.get_meta("top_color") != GameData.empty_color:
			var top_blocks = 0
			for j in i.get_child(0).get_child(0).get_children():
				if j.get_meta("color") == i.get_meta("top_color") && j.get_meta("hidden") == false:
					top_blocks = top_blocks + 1
				else:
					break
			i.set_meta("top_blocks", top_blocks)
			i.set_meta("empty_blocks", 0)
			# if this bottle is already sorted, mark it as completed
			if top_blocks == GameData.num_blocks:
				i.set_meta("is_complete", true)
				GameData.bottles_completed = GameData.bottles_completed  + 1
			else:
				i.set_meta("is_complete", false)
				# Loading from save file
		if i.get_meta("top_color") == GameData.empty_color:
			var top_blocks = 0
			var numEmpty = 0
			for j in i.get_child(0).get_child(0).get_children():
				if j.get_meta("color") != GameData.empty_color:
					i.set_meta("top_color", j.get_meta("color"))
					break
				else:
					numEmpty = numEmpty + 1
			
			for j in i.get_child(0).get_child(0).get_children():
				if j.get_meta("color") == i.get_meta("top_color") && j.get_meta("hidden") == false:
					top_blocks = top_blocks + 1
				else:
					break
			
			i.set_meta("top_blocks", top_blocks)
			i.set_meta("empty_blocks", numEmpty)
				


func print_metadata(bottles):
	for i in bottles.get_children():
		print(i.get_name(), ": top color: ", i.get_meta("top_color"), " top blocks: ", i.get_meta("top_blocks"))
		print("num empties = ", i.get_meta("empty_blocks"), " is_complete: ", i.get_meta("is_complete"))
		for j in i.get_child(0).get_child(0).get_children():
			print(j.get_name(), ": S", j.get_meta("color"))
	print("\n")	


func reset(level_data):
	GameData.bottles_completed = 0
	GameData.moves = 0
	set_colors(level_data)

		
func clear_level():
	# call_deferred forces it to wait for level to finish up before trying to free it.
	# if you don't, the game gets mad that you're trying to free level while level is 
	# still signaling and the game will crash

	call_deferred("_deferred_clear_level", level)
	
func _deferred_clear_level(level):

	get_parent().modulate = Color(.255, .255, .255, 1)
	var win_message = GameData.win_msg.instantiate()
	add_child(win_message)
	win_message.set_owner(get_node("."))
	win_message.get_child(0).position[0] = 300
	win_message.get_child(0).position[1] = 1500
	#win_message.get_child(0).get_child(0).text = "[center]Level Complete!\nMoves: %d[/center]" % GameData.moves
	win_message.get_child(0).get_child(0).text = "[center]\nLevel Complete![/center]" 
	win_message.get_child(0).get_child(1)._set_emitting(true)
	
	level.free()
	
	await get_tree().create_timer(1.5).timeout
	win_message.free()

	GameData.moves = 0
	get_parent().modulate = Color(1,1,1,1)


func display_help():
	help_var = help_screen.instantiate()
	help_var.set_name("HelpScreen")
	get_tree().root.add_child(help_var)
	help_var.set_owner(get_tree().root)

func clear_help_screen():
	call_deferred("_deffered_clear_help_screen", help_var)

func _deffered_clear_help_screen(help_var):
	help_var.free()
