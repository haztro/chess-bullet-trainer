extends "res://grid/precision/GridPrecision.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func custom_success():
	current_clicks += 1
	session_clicks += 1
	
	if current_clicks > GameData.CLICK_TARGET:
		disable_pieces()
		$TopBar/TargetLabel.visible = 0
		$CenterOverlay/RetryButton.show_and_hold($TopBar/TimeLabel.text, 1)
		$Timer.stop()
		
		if time_since_miss < GameData.record_time:
			GameData.record_time = time_since_miss
			GameData.record_clicks = current_clicks
			record_panel.set_clicks(GameData.record_clicks)
			record_panel.set_time(get_time_string(GameData.record_time))
	else:
		choose_rand_tile()
	
func custom_misclick():
	disable_pieces()
	$CenterOverlay/Countdown.mouse_filter = Control.MOUSE_FILTER_STOP
	$CenterOverlay/RetryButton.show_and_hold("Miss", 0)
	$Timer.stop()
	
func custom_start():
	enable_pieces()
	show_pieces()

func _on_RetryButton_pressed():
	hide_pieces()
	$CenterOverlay/RetryButton.hide_button()
	$CenterOverlay/Countdown.start()
	time_since_miss = 0
	current_clicks = 0
