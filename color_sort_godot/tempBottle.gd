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
	print("Button Pressed.")
	hasBeenPressed = true
	print(str(hasBeenPressed))
