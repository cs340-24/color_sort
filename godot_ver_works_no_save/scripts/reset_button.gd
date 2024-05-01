extends Button

# Called when the node enters the scene tree for the first time.
func _ready():
	pressed.connect(_button_pressed)


func _button_pressed():
	GameData.move_array.clear()
	GameData.reset_level.emit(GameData.level_data)
	GameData.reset_time.emit()
	GameData.sound_control.emit('buttonPress')
