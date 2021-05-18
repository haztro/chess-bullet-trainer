extends PanelContainer


export(String) var title = "Streak"

# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer2/Title.text = title
	
func _process(delta):
	pass
	
func set_time(value):
	$VBoxContainer2/VBoxContainer/ImageTextLabel.set_value(value)
	
func set_clicks(clicks):
	$VBoxContainer2/VBoxContainer/ImageTextLabel2.set_value(str(clicks))
	
