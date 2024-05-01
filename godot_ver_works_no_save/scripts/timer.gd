extends HBoxContainer

var time: float = 10000
var minutes: int = 0
var seconds: int = 0
var msec: int = 0
var initial_time: int = time
func _ready():
	$Minutes.visible = false  # Hide minutes initially
	$Seconds.visible = false
	$Msecs.visible = false
	# Connect to the challenge_mode signal to show minutes when it's emitted
	GameData.time_challenge_mode.connect(_on_challenge_mode)
	GameData.reset_time.connect(_reset_time)

# Callback function for the challenge_mode signal
func _on_challenge_mode():
	time = 10
	initial_time = time
	$Minutes.visible = true
	$Seconds.visible = true
	$Msecs.visible = true

func _add_time():
	time += 30
	initial_time = time

func _reset_time():
	if(initial_time > 20):
		initial_time -= 10
	time = initial_time

func _process(delta) -> void:
	time -= delta
	msec = fmod(time,1) * 100
	seconds = fmod(time, 60)
	minutes = fmod(time,3600) / 60
	$Minutes.text = "%02d:" % minutes
	$Seconds.text = "%02d:" % seconds
	$Msecs.text = "%02d" % msec
	
	if(minutes == 0 && seconds == 0 && msec == 0):
		GameData.move_array.clear()
		GameData.reset_level.emit(GameData.level_data)
		time = initial_time

