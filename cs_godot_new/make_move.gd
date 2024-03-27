extends GridContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	GameData.make_move.connect(make_move)

	
func make_move(bottle_from, bottle_to):
	var blocks_to_move # number of blocks getting moved. min of top blocks in source or
					   # empty blocks in destination
	var blocks         # vertical container holding the blocks
	

	if check_bottles(bottle_from, bottle_to):
		print("make_move: ", bottle_from.name, " ", bottle_to.name)
		print("top blocks: ", bottle_from.get_meta("top_blocks"), " empties: ", bottle_to.get_meta("empty_blocks"))
		print("moving ", min(bottle_from.get_meta("top_blocks"), bottle_to.get_meta("empty_blocks")), " blocks")
		
		blocks_to_move = min(bottle_from.get_meta("top_blocks"), bottle_to.get_meta("empty_blocks"))
		
		# color being moved
		var color = bottle_from.get_meta("top_color")
		bottle_to.set_meta("top_color", color)
		
		# index of the blocks being transferred
		var to_index = bottle_to.get_meta("empty_blocks")
		var from_index = bottle_from.get_meta("empty_blocks")
		
		for i in blocks_to_move:
			# need to decrement 1 since get_child indexes starting at 0 
			to_index = to_index - 1
			
			# change empty block to color
			
			bottle_to.get_child(0).get_child(0).get_child(to_index).get_theme_stylebox("panel").bg_color = color 
			
			# change color block to empty 
			bottle_from.get_child(0).get_child(0).get_child(i + from_index).get_theme_stylebox("panel").bg_color = GameData.empty_color
			

		# increment number of emtpy blocks in source bottle
		var new_empties = bottle_from.get_meta("empty_blocks") + blocks_to_move
		bottle_from.set_meta("empty_blocks", new_empties)
		
		# set new top color in source bottle 
		if bottle_from.get_meta("empty_blocks") != GameData.num_blocks:
			# increment from_index by block_to_move to get index of new top block after move
			from_index = from_index + blocks_to_move
			var new_color = bottle_from.get_child(0).get_child(0).get_child(from_index).get_theme_stylebox("panel").bg_color
			bottle_from.set_meta("top_color", new_color)
			
			# count consecutive blocks
			blocks = bottle_from.get_child(0).get_child(0).get_children()
			var top_blocks = 0
			for j in range(from_index, blocks.size()):
				if blocks[j].get_theme_stylebox("panel").bg_color == new_color:
					top_blocks = top_blocks + 1
				else:
					break
			bottle_from.set_meta("top_blocks", top_blocks)
				
		# bottle is empty
		else:
			bottle_from.set_meta("top_color", GameData.empty_color)
		
		# to_index will equal number of enpty blocks	
		bottle_to.set_meta("empty_blocks", to_index)
		
		# count consecutive top color blocks in source. skip over the empties.
		blocks = bottle_to.get_child(0).get_child(0).get_children()
		var top_blocks = 0
		# start at the first non-empty block
		for j in range(to_index, blocks.size()):
			if blocks[j].get_theme_stylebox("panel").bg_color == color:
				top_blocks = top_blocks + 1
			else:
				break
		bottle_to.set_meta("top_blocks", top_blocks)
		
		# if the number of top blocks == num_blocks, then this bottle is done! woo!
		if top_blocks == GameData.num_blocks:
			bottle_to.set_meta("is_complete", true)
			GameData.bottles_completed = GameData.bottles_completed  + 1
		else:
			bottle_to.set_meta("is_complete", false)
			
			
		get_parent().print_metadata(bottle_from.get_parent())
		
		if (GameData.bottles_completed == GameData.num_colors):
			print("emitting level complete")
			GameData.level_complete.emit()
	
	else:
		print("no move for you")	

	


func check_bottles(bottle_from, bottle_to):
	if bottle_from == bottle_to:
		print("bottles equal")
		return false
	if bottle_from.get_meta("is_complete") or bottle_to.get_meta("is_complete"):
		print("bottles complete")
		return false
	if bottle_to.get_meta("empty_blocks") == 0:
		print("bottle_to is full")
		return false
	if bottle_from.get_meta("top_color") == GameData.empty_color:
		print("bottle_from is empty")
		return false
	# if destination bottle isnt empty, see if top colors in both bottles match
	if bottle_to.get_meta("top_color") != GameData.empty_color:
		if bottle_to.get_meta("top_color") !=  bottle_from.get_meta("top_color"):
			print("top colors don't match")
			return false

	return true
		
