extends "res://grid/vision/GridVision.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	record_panel.set_clicks(GameData.record_clicks)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func check_record():
	GameData.record_time = 5000
	record_panel.set_time(GameData.record_time)
		
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
	$Timer.stop()
	time_since_miss = 5000
	$CenterOverlay/Countdown.mouse_filter = Control.MOUSE_FILTER_STOP
	$CenterOverlay/RetryButton.show_and_hold(str(current_clicks), 0)
	$TopBar/TargetLabel.visible = 0
	
	if current_clicks > GameData.record_clicks:
		GameData.record_clicks = current_clicks
		record_panel.set_clicks(GameData.record_clicks)
	
