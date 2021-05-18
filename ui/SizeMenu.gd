extends MarginContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().get_root().connect("size_changed", self, "_on_viewport_size_changed")
	_on_viewport_size_changed()
	VisualServer.set_default_clear_color(Color(1, 1, 1))
	
func _on_viewport_size_changed():
	rect_size = OS.get_window_size()
	

func _input(event):
	if Input.is_action_just_pressed("back"):
		GameData.goto_main_menu()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Control/Button.rect_position = $VBoxContainer/HBoxContainer/VBoxContainer/PanelContainer.rect_global_position - Vector2(20, 40)
	$Control/Button.rect_size = $VBoxContainer/HBoxContainer/VBoxContainer/PanelContainer.rect_size

	$Control/Button2.rect_position = $VBoxContainer/HBoxContainer/VBoxContainer2/PanelContainer2.rect_global_position - Vector2(20, 40)
	$Control/Button2.rect_size = $VBoxContainer/HBoxContainer/VBoxContainer2/PanelContainer2.rect_size
	
	$Control/Button3.rect_position = $VBoxContainer/HBoxContainer/VBoxContainer3/PanelContainer3.rect_global_position - Vector2(20, 40)
	$Control/Button3.rect_size = $VBoxContainer/HBoxContainer/VBoxContainer3/PanelContainer3.rect_size

func _on_4x4Btn_pressed():
	AudioManager.play("click", 0, 2)
	GameData.goto_difficulty_menu(GameData.BoardSize.SIZE_4x4)


func _on_6x6Btn_pressed():
	AudioManager.play("click", 0, 2)
	GameData.goto_difficulty_menu(GameData.BoardSize.SIZE_6x6)


func _on_8x8Btn_pressed():
	AudioManager.play("click", 0, 2)
	GameData.goto_difficulty_menu(GameData.BoardSize.SIZE_8x8)


func _on_BackBtn_pressed():
	AudioManager.play("click", 0, 2)
	GameData.goto_main_menu()


func _on_Button_pressed():
	AudioManager.play("click", 0, 2)
	GameData.goto_difficulty_menu(GameData.BoardSize.SIZE_4x4)


func _on_Button2_pressed():
	AudioManager.play("click", 0, 2)
	GameData.goto_difficulty_menu(GameData.BoardSize.SIZE_6x6)


func _on_Button3_pressed():
	AudioManager.play("click", 0, 2)
	GameData.goto_difficulty_menu(GameData.BoardSize.SIZE_8x8)
