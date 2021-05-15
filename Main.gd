extends MarginContainer




# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().get_root().connect("size_changed", self, "_on_viewport_size_changed")
#	var gs = grid_scene.instance()
#	add_child(gs)
#	gs.make_grid(Vector2(8, 8))
#	gs.choose_rand_tile()
#	gs.choose_rand_tile()
#	gs.choose_rand_tile()
	_on_viewport_size_changed()
	
func _on_viewport_size_changed():
	rect_size = OS.get_window_size()


func _on_FreeplayBtn_pressed():
	GameData.goto_size_menu(GameData.Mode.FREEPLAY)

func _on_VisionBtn_pressed():
	GameData.goto_chess_menu(GameData.Mode.VISION)

func _on_PrecisionBtn_pressed():
	GameData.goto_chess_menu(GameData.Mode.PRECISION)
