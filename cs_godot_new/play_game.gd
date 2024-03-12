extends Node

@onready var level
@onready var bottle 
@onready var blocks
@onready var block 

# Called when the node enters the scene tree for the first time.
func _ready():
	for level_data in GameData.levels:
		level = GameData.bottles_scene.instantiate()
		level.set_position(GameData.level_pos)
		level.set_size(GameData.level_size)
		level.set_name("Level")
		add_child(level)
		
		GameData.bottles_completed = 0
		GameData.bottles_pressed = 0
		load_level_data(level_data)
		
		# wait for level_complete signal
		level.connect("level_complete", self.clear_level)
		await level.level_complete
	

# Duplicate nodes to create numBottles bottles with numBlocks blocks each.
# Set the color values for the blocks and spacing around the bottles
func load_level_data(level_data):
	bottle = level.get_child(0)
	blocks = bottle.get_child(0)
	block = blocks.get_child(0)
	
	# for naming nodes
	var node_name
	
	# set columns and grid spacing
	level.columns = level_data["cols"]
	GameData.num_blocks = level_data["num_blocks"]
	GameData.num_colors = level_data["num_colors"]
	
	# adjust bottle separation for 2 rows
	if level_data["rows"] == 2:
		level.add_theme_constant_override("h_separation", 100)
		if level_data["cols"] != 4:
			level.add_theme_constant_override("v_separation", 200)

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
		
	# iterate through the color blocks, setting their colors
	var block_index = 0
	for i in level.get_children():
		# set the block's colors
		for j in i.get_child(0).get_children():
			var color = level_data["color_vals"][block_index]
			j.set_color(color)
			block_index = block_index + 1
			
			# set top color
			if j.get_name() == "Block1":
				GameData.top_color = color
				i.set_meta("top_color", GameData.top_color)
		
				# if top color is empty color, this is an empty bottle
				if GameData.top_color == GameData.empty_color:
					i.set_meta("empty_blocks", level_data["num_blocks"])
					i.set_meta("is_complete", false)
					
	# if bottle isn't empty, need to see how many consecutive blocks of top_color there are
	for i in level.get_children():
		# if bottle isn't empty
		if i.get_meta("top_color") != GameData.empty_color:
			var top_blocks = 0
			for j in i.get_child(0).get_children():
				if j.get_color() == i.get_meta("top_color"):
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
	
						
	return true



func print_metadata(bottles):
	for i in bottles.get_children():
		print(i.get_name(), ": top color: ", i.get_meta("top_color"), " top blocks: ", i.get_meta("top_blocks"))
		print("num empties = ", i.get_meta("empty_blocks"), " is_complete: ", i.get_meta("is_complete"))
		for j in i.get_child(0).get_children():
			print(j.get_name(), ": S", j.get_color())
	print("\n")	


		
func clear_level():
	# call_deferred forces it to wait for level to finish up before trying to free it.
	# if you don't, the game gets mad that you're trying to free level while level is 
	# still signaling and the game will crash
	call_deferred("_deferred_clear_level", level)
	
func _deferred_clear_level(level):
	level.free()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
