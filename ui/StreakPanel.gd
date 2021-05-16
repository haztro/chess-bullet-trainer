extends VBoxContainer


export(String) var title = "Streak"
export(String) var label1 = "Time:"
export(String) var label2 = "Clicks:"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Title.text = title
	$HBoxContainer/VBoxContainer/Label1.text = label1
	$HBoxContainer/VBoxContainer/Label2.text = label2

func set_time(time, has_mins=1):
	$HBoxContainer/VBoxContainer2/TimeLabel.set_time(time, has_mins)
	
func set_clicks(clicks):
	$HBoxContainer/VBoxContainer2/ClicksLabel.text = str(clicks)
	
