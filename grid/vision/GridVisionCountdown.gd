extends "res://grid/vision/GridVision.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	record_panel.set_clicks(GameData.score["vision"]["countdown"]["clicks"])
	$Timer2.wait_time = GameData.COUNTDOWN_TIME

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_top_bar_labels():
	$TopBar/TargetLabel.text = target
	$TopBar/ClickCountLabel.text = str(current_clicks)
	$TopBar/TimeLabel.text = get_time_string(GameData.COUNTDOWN_TIME * 1000 - time_since_miss, 0)

func check_record():
	GameData.score["vision"]["countdown"]["time"] = GameData.COUNTDOWN_TIME * 1000
	record_panel.set_time(get_time_string(GameData.score["vision"]["countdown"]["time"], 0))
		
func check_record_time():
	pass

func successful_click():
	choose_rand_tile()
	
func missed_click():
	$CenterOverlay/Countdown.mouse_filter = Control.MOUSE_FILTER_STOP
	$CenterOverlay/RetryButton.show_and_hold("Miss", 0)
	target = ""
	$Timer.stop()
	$Timer2.stop()
	
func custom_start():
	$Timer2.start()

func _on_RetryButton_pressed():
	$CenterOverlay/RetryButton.hide_button()
	$CenterOverlay/Countdown.start()
	time_since_miss = 0
	current_clicks = 0

func _on_Timer2_timeout():
	time_since_miss = GameData.COUNTDOWN_TIME * 1000
	$Timer.stop()
	$CenterOverlay/Countdown.mouse_filter = Control.MOUSE_FILTER_STOP
	$CenterOverlay/RetryButton.show_and_hold(str(current_clicks), 0)
	target = ""
	
	check_record()
	
	if current_clicks > GameData.score["vision"]["countdown"]["clicks"]:
		GameData.score["vision"]["countdown"]["clicks"] = current_clicks
		record_panel.set_clicks(GameData.score["vision"]["countdown"]["clicks"])
	
