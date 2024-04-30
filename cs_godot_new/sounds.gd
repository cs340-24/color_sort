extends AudioStreamPlayer
var currentSound
signal toggleMusic


#Starts muted currently until release, to change.
#sounds made via BeepBox
func _ready():
	self.volume_db = -80
	get_parent().get_node("Background_music").volume_db = -80
	GameData.sound_control.connect(sound_control_func)
	GameData.volume_control.connect(vol_control_func)
	


func vol_control_func(volType, volVal):
	if volType == 'Music':
		get_parent().get_node("Background_music").volume_db = volVal
	elif volType == 'Sound':
		self.volume_db = volVal
	
	
func sound_control_func(soundType):
	if soundType == 'toggleMute':
		print ("!! Mute Button Pressed !!")
		currentSound = load('res://sounds/buttonWoodBlock.wav')
		self.stream = currentSound
		self.play()
		if self.volume_db != -80:
			self.volume_db = -80
			get_parent().get_node("Background_music").volume_db = -80
			get_parent().get_node("Toolbar/Buttons/Volume/VolBackground/Panel/SoundBox/Sound_Slider").editable = false
			get_parent().get_node("Toolbar/Buttons/Volume/VolBackground/Panel/SoundBox/Music_Slider").editable = false
		elif self.volume_db == -80:
			self.volume_db = -20
			get_parent().get_node("Background_music").volume_db = 0
			get_parent().get_node("Toolbar/Buttons/Volume/VolBackground/Panel/SoundBox/Sound_Slider").editable = true
			get_parent().get_node("Toolbar/Buttons/Volume/VolBackground/Panel/SoundBox/Music_Slider").editable = true
	
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
