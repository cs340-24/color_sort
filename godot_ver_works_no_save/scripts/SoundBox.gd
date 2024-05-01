extends VBoxContainer
signal changeVolume

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_music_slider_value_changed(value):
	GameData.volume_control.emit("Music", $Music_Slider.value)

func _on_sound_slider_value_changed(value):
	GameData.volume_control.emit("Sound", $Sound_Slider.value)
