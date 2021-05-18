extends PanelContainer

signal colour_changed

# Called when the node enters the scene tree for the first time.
func _ready():
	if GameData.white == 0:
		$VBoxContainer2/VBoxContainer/HBoxContainer/TextureButton.pressed = 1
	else:
		$VBoxContainer2/VBoxContainer/HBoxContainer/TextureButton.pressed = 0
		
	if GameData.coords == 1:
		$VBoxContainer2/VBoxContainer/HBoxContainer2/CheckButton.pressed = 1
	else:
		$VBoxContainer2/VBoxContainer/HBoxContainer2/CheckButton.pressed = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TextureButton_toggled(button_pressed):
	if button_pressed:
		GameData.white = 0
	else:
		GameData.white = 1
	emit_signal("colour_changed")


func _on_CheckButton_toggled(button_pressed):
	if button_pressed:
		GameData.coords = 1
	else:
		GameData.coords = 0
