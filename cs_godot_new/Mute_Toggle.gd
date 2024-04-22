extends Button
var isMuted = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	GameData.sound_control.emit("toggleMute")
	print ("Pressed Mute ")
	if isMuted == 0:
		self.text = "Unmute Volume"
		isMuted = 1
		
	else:
		self.text = "Mute Volume"
		isMuted = 0

