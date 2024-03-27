extends Button

# Called when the node enters the scene tree for the first time.
func _ready():	
	self.pressed.connect(_button_pressed)

func _button_pressed():
	print("BOTTLE PRESSED")
	# 1st bottle selected
	if GameData.bottles_pressed == 0 or GameData.bottles_pressed == 2:
		print(get_parent().get_name(), " pressed 1st")
		GameData.bottles_pressed = 1
		GameData.bottle_from = get_parent()

		
	# 2nd bottle selected
	elif GameData.bottles_pressed == 1:
		button_pressed = false
		print(get_parent().get_name(), " pressed 2nd")
		GameData.bottle_from.get_child(0).button_pressed = false
		GameData.bottles_pressed = 2
		GameData.bottle_to = get_parent()

		GameData.emit_signal("make_move", GameData.bottle_from, GameData.bottle_to)
		#GameData.bottle_from.get_child(1).modulate = Color(0,0,0,0)

