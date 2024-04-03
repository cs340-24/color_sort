extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	pressed.connect(_on_pressed)



func _on_pressed():
	GameData.emit_signal("undo_move") # Replace with function body.
