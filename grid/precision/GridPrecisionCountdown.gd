extends "res://grid/precision/GridPrecision.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	record_panel.set_clicks(GameData.score["precision"]["countdown"]["clicks"])
	$Timer2.wait_time = GameData.COUNTDOWN_TIME

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_top_bar_labels():
#	$TopBar/TargetLabel.text = target
	$TopBar/ClickCountLabel.text = str(current_clicks)
	$TopBar/TimeLabel.text = get_time_string(GameData.COUNTDOWN_TIME * 1000 - time_since_miss, 0)

func custom_record():
	record_panel.set_clicks(GameData.score["precision"]["countdown"]["clicks"])
	record_panel.set_time(get_time_string(GameData.score["precision"]["countdown"]["time"], GameData.score["precision"]["countdown"]["time"] >= 60000))

func check_record():
	GameData.score["precision"]["countdown"]["time"] = GameData.COUNTDOWN_TIME * 1000
	record_panel.set_time(get_time_string(GameData.score["precision"]["countdown"]["time"], GameData.score["precision"]["countdown"]["time"] >= 60000))
		
func check_record_time():
	pass

func custom_success():
	choose_rand_tile()
	current_clicks += 1
	session_clicks += 1
	
func custom_misclick():
	$ActivePiece.start_square.get_node("ColorRect2").visible = 0
	hide_pieces()
	$CenterOverlay/Countdown.mouse_filter = Control.MOUSE_FILTER_STOP
	$CenterOverlay/RetryButton.show_and_hold("Miss", 0)
#	target = ""
	$Timer.stop()
	$Timer2.stop()
	
func custom_start():
	$Timer2.start()
	enable_pieces()
	show_pieces()

func _on_RetryButton_pressed():
	hide_pieces()
	$CenterOverlay/RetryButton.hide_button()
	$CenterOverlay/Countdown.start()
	current_clicks = 0
	time_since_miss = 0

func _on_Timer2_timeout():
	$ActivePiece.is_grabbed = 0
	time_since_miss = GameData.COUNTDOWN_TIME * 1000
	disable_pieces()
	hide_pieces()
	$Timer.stop()
	$CenterOverlay/Countdown.mouse_filter = Control.MOUSE_FILTER_STOP
	$CenterOverlay/RetryButton.show_and_hold(str(current_clicks), 0)
#	target = ""

	print(current_clicks)
	print(GameData.score["precision"]["countdown"]["clicks"])
	
	if current_clicks > GameData.score["precision"]["countdown"]["clicks"]:
		GameData.score["precision"]["countdown"]["clicks"] = current_clicks
		record_panel.set_clicks(GameData.score["precision"]["countdown"]["clicks"])
