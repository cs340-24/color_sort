extends GridContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	GameData.make_move.connect(make_move)
	GameData.undo_move.connect(undo_move)

func make_move(bottle_from, bottle_to, undo):
	var blocks_to_move # number of blocks getting moved. min of top blocks in source or
					   # empty blocks in destination
	var blocks         # vertical container holding the blocks
	var top_blocks

	if check_bottles(bottle_from, bottle_to, undo):
		GameData.sound_control.emit("canMove")
		
		if(undo):
			blocks_to_move = GameData.move_array.pop_back()
			if blocks_to_move == null:
				return false
		else:
			blocks_to_move = min(bottle_from.get_meta("top_blocks"), bottle_to.get_meta("empty_blocks"))
			GameData.move_array.push_back(bottle_from.get_meta("top_blocks"))
			GameData.move_array.push_back(bottle_to.get_meta("top_blocks"))
			GameData.moves += 1
			
		# color being moved
		var color = bottle_from.get_meta("top_color")
		bottle_to.set_meta("top_color", color)
		
		# index of the blocks being transferred
		var to_index = bottle_to.get_meta("empty_blocks")
		var from_index = bottle_from.get_meta("empty_blocks")
		
		for i in blocks_to_move:
			# need to decrement 1 since get_child indexes starting at 0 
			to_index = to_index - 1
			
			# This is where implementing the Tween node would take place, since this is where the top colors change.
			if (!undo):
				# change empty block to color
				var tween = get_tree().create_tween().set_parallel(true)
				tween.tween_property(bottle_to.get_child(0).get_child(0).get_child(to_index).get_theme_stylebox("panel"), "bg_color", color, 0.25)

			
				# change color block to empty
				tween.tween_property(bottle_from.get_child(0).get_child(0).get_child(i + from_index).get_theme_stylebox("panel"), "bg_color", GameData.empty_color, 0.25)
				await tween.finished
				

				bottle_to.get_child(0).get_child(0).get_child(to_index).set_meta("color", color)
				bottle_to.get_child(0).get_child(0).get_child(to_index).set_meta("hidden", false)
				bottle_from.get_child(0).get_child(0).get_child(i + from_index).set_meta("color", GameData.empty_color)
			else:
				bottle_to.get_child(0).get_child(0).get_child(to_index).get_theme_stylebox("panel").bg_color = color
				bottle_to.get_child(0).get_child(0).get_child(to_index).set_meta("color", color)
				bottle_from.get_child(0).get_child(0).get_child(i + from_index).get_theme_stylebox("panel").bg_color = GameData.empty_color
				bottle_from.get_child(0).get_child(0).get_child(i + from_index).set_meta("color", GameData.empty_color)
				
		# increment number of emtpy blocks in source bottle
		var new_empties = bottle_from.get_meta("empty_blocks") + blocks_to_move
		bottle_from.set_meta("empty_blocks", new_empties)
		
		# set new top color in source bottle 
		if bottle_from.get_meta("empty_blocks") != GameData.num_blocks:
			# increment from_index by block_to_move to get index of new top block after move
			from_index = from_index + blocks_to_move
			print("get_meta: ", bottle_from.get_child(0).get_child(0).get_child(from_index).get_meta("color"))
			print("bg_color: ", bottle_from.get_child(0).get_child(0).get_child(from_index).get_theme_stylebox("panel").bg_color)
			var new_color = bottle_from.get_child(0).get_child(0).get_child(from_index).get_meta("color")
			bottle_from.get_child(0).get_child(0).get_child(from_index).get_theme_stylebox("panel").bg_color = new_color
			bottle_from.get_child(0).get_child(0).get_child(from_index).set_meta("hidden", false)
			print("new color = ", new_color, "  from_index = ", from_index)
			bottle_from.set_meta("top_color", new_color)
			
			# count consecutive blocks
			blocks = bottle_from.get_child(0).get_child(0).get_children()
			top_blocks = 1
			for j in range(from_index+1, blocks.size()):
				if blocks[j].get_meta("color") == new_color && blocks[j].get_meta("hidden") == false:
					top_blocks = top_blocks + 1
				else:
					break
			bottle_from.set_meta("top_blocks", top_blocks)
				
		# bottle is empty
		else:
			bottle_from.set_meta("top_color", GameData.empty_color)
		
		# to_index will equal number of enpty blocks	
		bottle_to.set_meta("empty_blocks", to_index)
		
		# count consecutive top color blocks in destination. skip over the empties.
		# start at the first non-empty block
		blocks = bottle_to.get_child(0).get_child(0).get_children()
		top_blocks = 0

		for j in range(to_index, blocks.size()):
			if blocks[j].get_meta("color") == color && blocks[j].get_meta("hidden") == false:
			#if blocks[j].get_theme_stylebox("panel").bg_color == color:
				top_blocks = top_blocks + 1
			else:
				break
		bottle_to.set_meta("top_blocks", top_blocks)
		if(undo):
			bottle_from.set_meta("top_blocks", GameData.move_array.pop_back())
			bottle_to.set_meta("top_blocks", GameData.move_array.pop_back())
			if(bottle_from.get_meta("is_complete")):
				bottle_from.set_meta("is_complete", false)
				GameData.bottles_completed = GameData.bottles_completed - 1
				
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
			GameData.sound_control.emit("complete")
	
	else:
		print("no move for you")
		GameData.sound_control.emit('noMove')	

	if(!undo):
		GameData.move_array.push_back(blocks_to_move)
		GameData.move_array.push_back(bottle_from)
		GameData.move_array.push_back(bottle_to)
		
		
func check_bottles(bottle_from, bottle_to, undo):
	if undo:
		return true
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
	
func undo_move():
	if(GameData.move_array.is_empty()):
		print("No move to undo please make a move")
	else:
		make_move(GameData.move_array.pop_back(),GameData.move_array.pop_back(),1)
