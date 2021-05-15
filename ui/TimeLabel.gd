extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func set_time(time):
	var mins = floor(time / 60000)
	var seconds = floor((time - mins * 60000) / 1000)
	var huns = time - mins * 60000 - seconds * 1000
	text = "%02d:%02d:%02d" % [mins, seconds, huns / 10]
