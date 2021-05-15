extends MarginContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().get_root().connect("size_changed", self, "_on_viewport_size_changed")
	_on_viewport_size_changed()
	
func _on_viewport_size_changed():
	rect_size = OS.get_window_size()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_4x4Btn_pressed():
	GameData.goto_difficulty_menu(GameData.BoardSize.SIZE_4x4)


func _on_6x6Btn_pressed():
	GameData.goto_difficulty_menu(GameData.BoardSize.SIZE_6x6)


func _on_8x8Btn_pressed():
	GameData.goto_difficulty_menu(GameData.BoardSize.SIZE_8x8)


func _on_BackBtn_pressed():
	GameData.goto_main_menu()
