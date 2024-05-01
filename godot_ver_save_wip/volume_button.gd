extends Button
var isMuted = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pressed.connect(_button_pressed)


func _button_pressed():
	if $VolBackground.visible == false:
		$VolBackground.popup()
		
	GameData.sound_control.emit("buttonPressed")

func _process(delta):
	if $VolBackground.visible == true:
		get_parent().get_parent().get_parent().modulate = Color(.255, .255, .255, 1)
	else:
		get_parent().get_parent().get_parent().modulate = Color(1,1,1,1)
