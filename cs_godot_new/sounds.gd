extends AudioStreamPlayer
var currentSound
signal toggleMusic


#Starts muted currently until release, to change.
#sounds made via BeepBox
func _ready():
	self.volume_db = -80
	get_parent().get_node("Background_music").volume_db = -80
	GameData.sound_control.connect(sound_control_func)


func sound_control_func(soundType):
	if soundType == 'toggleMute':
		print ("!! Mute Button Pressed !!")
		currentSound = load('res://sounds/buttonWoodBlock.wav')
		self.stream = currentSound
		self.play()
		if self.volume_db != -80:
			self.volume_db = -80
			get_parent().get_node("Background_music").volume_db = -80
		elif self.volume_db == -80:
			self.volume_db = -20
			get_parent().get_node("Background_music").volume_db = -20
	
	elif soundType == 'bottleSelect':
		currentSound = load('res://sounds/bottleSelect.wav')
		self.stream = currentSound
		if self.volume_db != -80:
			self.volume_db = -20
		self.play()
		
	elif soundType == 'buttonPress':
		currentSound = load('res://sounds/buttonWoodBlock.wav')
		self.stream = currentSound
		if self.volume_db != -80:
			self.volume_db = -20
		self.play()
	
	elif soundType == 'noMove':
		currentSound = load('res://sounds/noMove.wav')
		self.stream = currentSound
		if self.volume_db != -80:
			self.volume_db = -20
		self.play()
	
	elif soundType == 'canMove':
		currentSound = load('res://sounds/canMove.wav')
		self.stream = currentSound
		if self.volume_db != -80:
			self.volume_db = -20
		self.play()

	elif soundType == 'complete':
		currentSound = load('res://sounds/levelComplete.wav')
		self.stream = currentSound
		if self.volume_db != -80:
			self.volume_db = -10
		self.play()
