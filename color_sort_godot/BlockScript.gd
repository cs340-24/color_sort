extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

var color_num: int = 0: set = _set_color_num, get = _get_color_num

func _set_color_num(new_value : int):
	color_num = new_value

func _get_color_num():
	return color_num
