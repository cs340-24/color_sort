extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	pressed.connect(_button_pressed)


func _button_pressed():
	print("emitting start game signal")
	GameData.start.emit()
