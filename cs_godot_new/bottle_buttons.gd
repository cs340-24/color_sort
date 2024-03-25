extends Control

# Called when the node enters the scene tree for the first time.
func _ready():	
	var button = Button.new()
	var rect_behind = ColorRect.new()
	# this makes it invisible
	button.modulate = Color(0,0,0,0)
	rect_behind.modulate = Color(0,0,0,0)
	rect_behind.z_index = -1
	add_child(rect_behind)
	add_child(button)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _button_pressed():
	# 1st bottle selected
	if GameData.bottles_pressed == 0 or GameData.bottles_pressed == 2:
		print(get_name(), " pressed 1st")
		GameData.bottles_pressed = 1
		GameData.bottle_from = self
		
		# Change the color and position of the highlight box
		get_child(1).modulate = Color(100, 100, 100, 1)
		get_child(1).size[0] += 20
		get_child(1).global_position[0] -= 10
		get_child(1).size[1] += 20
		get_child(1).global_position[1] -= 10
	# 2nd bottle selected
	elif GameData.bottles_pressed == 1:
		print(get_name(), " pressed 2nd")
		
		# Change the color and position of the highlight box
		get_child(1).modulate = Color(100, 100, 100, 1)
		get_child(1).size[0] += 20
		get_child(1).global_position[0] -= 10
		get_child(1).size[1] += 20
		get_child(1).global_position[1] -= 10
		
		GameData.bottles_pressed = 2
		GameData.bottle_to = self
		GameData.emit_signal("make_move", GameData.bottle_from, GameData.bottle_to)
		
		# Reset the invisible boxes that creates the highlight effect for both bottles
		GameData.bottle_from.get_child(1).modulate = Color(0,0,0,0)
		GameData.bottle_from.get_child(1).size[0] -= 20
		GameData.bottle_from.get_child(1).global_position[0] += 10
		GameData.bottle_from.get_child(1).size[1] -= 20
		GameData.bottle_from.get_child(1).global_position[1] += 10

		GameData.bottle_to.get_child(1).modulate = Color(0,0,0,0)
		GameData.bottle_to.get_child(1).size[0] -= 20
		GameData.bottle_to.get_child(1).global_position[0] += 10
		GameData.bottle_to.get_child(1).size[1] -= 20
		GameData.bottle_to.get_child(1).global_position[1] += 10
		

