extends Button

# Called when the node enters the scene tree for the first time.
func _ready():
	pressed.connect(_button_pressed)


func _button_pressed():
	print("emitting reset level signal")
	GameData.reset_level.emit(GameData.level_data)
