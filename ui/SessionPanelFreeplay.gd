extends "res://ui/StreakPanel.gd"


export(String) var label3 = "Misses:"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#func set_clicks(clicks):
#	$VBoxContainer/ImageTextLabel2.set_value(clicks)

func set_misses(misses):
	$VBoxContainer2/VBoxContainer/ImageTextLabel3.set_value(misses)
	
func set_accuracy(value):
	$VBoxContainer2/VBoxContainer/ImageTextLabel4.set_value(str(value) + "%")
	
func set_speed(value):
	$VBoxContainer2/VBoxContainer/ImageTextLabel3.set_value(value)
