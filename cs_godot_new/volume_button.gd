extends Button
var isMuted = 1

# Called when the node enters the scene tree for the first time.
func _ready():
		pressed.connect(_button_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _button_pressed():
	
	if $VolBackground.visible == true:
		$VolBackground.hide()
	else:
		$VolBackground.show()
	GameData.sound_control.emit("buttonPressed")
