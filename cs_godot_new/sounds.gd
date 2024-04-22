extends AudioStreamPlayer
var currentSound

# Called when the node enters the scene tree for the first time.
func _ready():
	GameData.sound_control.connect(sound_control_func)


func sound_control_func(soundType):
	if soundType == 'toggleMute':
		print ("!! Mute Button Pressed !!")
	#	currentSound = load('res://sounds/muteButton.wav')
		
		#if volume_db
			#pass
