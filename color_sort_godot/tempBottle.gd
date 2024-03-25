extends ColorRect


var hasBeenPressed
var num
# Called when the node enters the scene tree for the first time.
func _ready():
	hasBeenPressed = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_bottle_pressed_pressed():
	if hasBeenPressed == false:
		print("Button Pressed.")
		hasBeenPressed = true
		color = Color(0.02,0.40,0.42, 1)
	elif hasBeenPressed == true:
		hasBeenPressed = false
		color = Color(0.07,0.77,0.80, 1)
	print(str(hasBeenPressed))


