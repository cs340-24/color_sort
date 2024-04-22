extends Button
var isMuted = 1

# Called when the node enters the scene tree for the first time.
func _ready():
		pressed.connect(_button_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _button_pressed():
	GameData.sound_control.emit("toggleMute")
	if isMuted == 0:
		self.text = 'Unmute'
		isMuted = 1
		
	else:
		self.text = 'Mute'
		isMuted = 0
