extends Button

# Called when the node enters the scene tree for the first time.
func _ready():
	pressed.connect(_button_pressed)

func _button_pressed():
	# Disable the start button
	GameData.start.emit()
	GameData.time_challenge_mode.emit()
	# Enable the timer
