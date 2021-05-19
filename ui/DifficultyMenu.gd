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
func _process(delta):
	$Control/MarginContainer.rect_size = $Control.rect_size

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


func _on_EasyBtn_mouse_entered():
	$Control/MarginContainer/ModeTip.show_tip()


func _on_EasyBtn_mouse_exited():
	$Control/MarginContainer/ModeTip.hide_tip()


func _on_NormalBtn_mouse_entered():
	$Control/MarginContainer/ModeTip2.show_tip()


func _on_NormalBtn_mouse_exited():
	$Control/MarginContainer/ModeTip2.hide_tip()


func _on_HardBtn_mouse_entered():
	$Control/MarginContainer/ModeTip3.show_tip()


func _on_HardBtn_mouse_exited():
	$Control/MarginContainer/ModeTip3.hide_tip()


func _on_ExtremeBtn_mouse_entered():
	$Control/MarginContainer/ModeTip4.show_tip()


func _on_ExtremeBtn_mouse_exited():
	$Control/MarginContainer/ModeTip4.hide_tip()
