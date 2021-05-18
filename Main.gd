extends MarginContainer




# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().get_root().connect("size_changed", self, "_on_viewport_size_changed")
	_on_viewport_size_changed()
	VisualServer.set_default_clear_color(Color(1, 1, 1))
	
func _on_viewport_size_changed():
	rect_size = OS.get_window_size()


func _on_FreeplayBtn_pressed():
	AudioManager.play("click", 0, 2)
	GameData.goto_size_menu(GameData.Mode.FREEPLAY)

func _on_VisionBtn_pressed():
	AudioManager.play("click", 0, 2)
	GameData.goto_chess_menu(GameData.Mode.VISION)

func _on_PrecisionBtn_pressed():
	AudioManager.play("click", 0, 2)
	GameData.goto_chess_menu(GameData.Mode.PRECISION)
