extends VBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _notification(what):
		if what == NOTIFICATION_SORT_CHILDREN:
		# Must re-sort the children
			for c in get_children():
				# Fit to own size
				fit_child_in_rect(c, Rect2(Vector2(), rect_size))

func set_some_setting():
	# Some setting changed, ask for children re-sort.
	queue_sort()
