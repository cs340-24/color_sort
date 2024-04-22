extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	pressed.connect(_button_pressed)


func _button_pressed():
	GameData.start.emit()
	GameData.sound_control.emit('buttonPress')
