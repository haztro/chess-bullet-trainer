extends MarginContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().get_root().connect("size_changed", self, "_on_viewport_size_changed")
	_on_viewport_size_changed()
	VisualServer.set_default_clear_color(Color(1, 1, 1))
	
func _on_viewport_size_changed():
	rect_size = OS.get_window_size()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
	if Input.is_action_just_pressed("back"):
		GameData.goto_main_menu()

func _on_BackBtn_pressed():
	AudioManager.play("click", 0, 2)
	GameData.goto_main_menu()


func _on_FreeplayBtn_pressed():
	AudioManager.play("click", 0, 2)
	if GameData.mode == GameData.Mode.VISION:
		GameData.start_vision_freeplay()
	elif GameData.mode == GameData.Mode.PRECISION:
		GameData.start_precision_freeplay()

func _on_TimeTrialBtn_pressed():
	AudioManager.play("click", 0, 2)
	if GameData.mode == GameData.Mode.VISION:
		GameData.start_vision_time()
	elif GameData.mode == GameData.Mode.PRECISION:
		GameData.start_precision_time()

func _on_CountdownBtn_pressed():
	AudioManager.play("click", 0, 2)
	if GameData.mode == GameData.Mode.VISION:
		GameData.start_vision_countdown()
	elif GameData.mode == GameData.Mode.PRECISION:
		GameData.start_precision_countdown()
