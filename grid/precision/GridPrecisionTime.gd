extends "res://grid/precision/GridPrecision.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func custom_record():
	record_panel.set_clicks(GameData.score["precision"]["time"]["clicks"])
	if GameData.score["precision"]["time"]["time"] != 99999999999:
		record_panel.set_time(get_time_string(GameData.score["precision"]["time"]["time"], GameData.score["precision"]["time"]["time"] >= 60000))
	else:
		record_panel.set_time(get_time_string(0, 0))

func custom_success():
	current_clicks += 1
	session_clicks += 1
	
	if current_clicks > GameData.CLICK_TARGET:
		disable_pieces()
		hide_pieces()
		$TopBar/TargetLabel.visible = 0
		$CenterOverlay/RetryButton.show_and_hold(get_time_string(time_since_miss, time_since_miss >= 60000), 1)
		$Timer.stop()
		
		check_record()
		
		if time_since_miss < GameData.score["precision"]["time"]["time"]:
			GameData.score["precision"]["time"]["time"] = time_since_miss
			GameData.score["precision"]["time"]["clicks"] = current_clicks
			record_panel.set_clicks(GameData.score["precision"]["time"]["clicks"])
			record_panel.set_time(get_time_string(GameData.score["precision"]["time"]["time"], GameData.score["precision"]["time"]["time"] >= 60000))
	else:
		choose_rand_tile()
	
func custom_misclick():
	$ActivePiece.start_square.get_node("ColorRect2").visible = 0
	disable_pieces()
	hide_pieces()
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
