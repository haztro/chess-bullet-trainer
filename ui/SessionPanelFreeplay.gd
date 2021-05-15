extends "res://ui/StreakPanel.gd"


export(String) var label3 = "Misses:"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func set_misses(misses):
	$HBoxContainer/VBoxContainer2/MissesLabel.text = str(misses)
