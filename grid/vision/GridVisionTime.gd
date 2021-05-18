extends "res://grid/vision/GridVision.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func check_record():
	pass
		
func check_record_time():
	pass

func successful_click():
	if current_clicks > GameData.CLICK_TARGET:
		$TopBar/TargetLabel.visible = 0
		$CenterOverlay/RetryButton.show_and_hold(get_time_string(time_since_miss, time_since_miss >= 60000), 1)
		$Timer.stop()
		
		if time_since_miss < GameData.score["vision"]["time"]["time"]:
			GameData.score["vision"]["time"]["time"] = time_since_miss
			GameData.score["vision"]["time"]["clicks"] = current_clicks
			record_panel.set_clicks(GameData.score["vision"]["time"]["clicks"])
			record_panel.set_time(get_time_string(GameData.score["vision"]["time"]["time"]))
	else:
		choose_rand_tile()
	
func missed_click():
	$CenterOverlay/Countdown.mouse_filter = Control.MOUSE_FILTER_STOP
	$CenterOverlay/RetryButton.show_and_hold("Miss", 0)
	target = ""
	$Timer.stop()

func _on_RetryButton_pressed():
	$CenterOverlay/RetryButton.hide_button()
	$CenterOverlay/Countdown.start()
	time_since_miss = 0
	current_clicks = 0
