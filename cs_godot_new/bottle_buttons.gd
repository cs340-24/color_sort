extends Control


# Called when the node enters the scene tree for the first time.
func _ready():	
	get_child(0).pressed.connect(_button_pressed)

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

		GameData.emit_signal("make_move", GameData.bottle_from, GameData.bottle_to)
		#GameData.bottle_from.get_child(1).modulate = Color(0,0,0,0)

