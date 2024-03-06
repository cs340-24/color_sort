extends VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# bool complete: true if the bottle is done (bottle is full and all colors match)
var complete: bool = false: set = _set_complete, get = _get_complete

func _set_complete(new_value : bool):
	complete = new_value
	
func _get_complete():
	return complete


# consec_blocks: the number of consecutive blocks of the top color in the bottle
# If the bottle has 2 green blocks on top, consec_blocks = 2	
var consec_blocks: int = 0: set = _set_consec_blocks, get = _get_consec_blocks

func _set_consec_blocks(new_value : int):
	consec_blocks = new_value
	
func _get_consec_blocks():
	return consec_blocks
	
	
# empty_blocks: number of empty blocks in the bottle
var empty_blocks: int = 0: set = _set_empty_blocks, get = _get_empty_blocks

func _set_empty_blocks(new_value : int):
	empty_blocks = new_value
	
func _get_empty_blocks():
	return empty_blocks
	
	
# the int corresponding to the top color in the bottle
var top_color: int = 0: set = _set_top_color, get = _get_top_color

func _set_top_color(new_value : int):
	top_color = new_value

func _get_top_color():
	return top_color

