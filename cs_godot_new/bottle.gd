extends Control

# Called when the node enters the scene tree for the first time.
func _ready():	
	var button = Button.new()
	# this makes it invisible
	button.modulate = Color(0,0,0,0)
	button.pressed.connect(self._button_pressed)
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
	# 2nd bottle selected
	elif GameData.bottles_pressed == 1:
		print(get_name(), " pressed 2nd")
		GameData.bottles_pressed = 2
		GameData.bottle_to = self
		get_parent().make_move(GameData.bottle_from, GameData.bottle_to)

