extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	var button = Button.new()
	button.modulate = Color(0,0,0,0)
	button.pressed.connect(self._button_pressed)
	add_child(button)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _button_pressed():
	# 1st bottle selected
	if get_parent().get_parent().bottlesPressed == 0 or get_parent().get_parent().bottlesPressed == 2:
		print(get_name(), " pressed 1st")
		get_parent().get_parent().bottlesPressed = 1
		get_parent().get_parent().bottleFrom = self
	# 2nd bottle selected
	elif get_parent().get_parent().bottlesPressed == 1:
		print(get_name(), " pressed 2nd")
		get_parent().get_parent().bottlesPressed = 2
		get_parent().get_parent().bottleTo = self
		print("makeMove(", get_parent().get_parent().bottleFrom.get_name(), ", ", get_parent().get_parent().bottleTo.get_name(), ")")	
