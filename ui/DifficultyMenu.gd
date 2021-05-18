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
		GameData.goto_size_menu(GameData.mode)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_EasyBtn_pressed():
	AudioManager.play("click", 0, 2)
	GameData.start_freeplay(GameData.Difficulty.EASY)

func _on_NormalBtn_pressed():
	AudioManager.play("click", 0, 2)
	GameData.start_freeplay(GameData.Difficulty.NORMAL)

func _on_HardBtn_pressed():
	AudioManager.play("click", 0, 2)
	GameData.start_freeplay(GameData.Difficulty.HARD)

func _on_ExtremeBtn_pressed():
	AudioManager.play("click", 0, 2)
	GameData.start_freeplay(GameData.Difficulty.EXTREME)

func _on_BackBtn_pressed():
	AudioManager.play("click", 0, 2)
	GameData.goto_size_menu(GameData.mode)
