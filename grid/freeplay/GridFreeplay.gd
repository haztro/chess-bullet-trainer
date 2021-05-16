extends "res://grid/Grid.gd"

var session_time = 0

onready var session_panel = get_node("HBoxContainer/VBoxContainer/HBoxContainer/Toolbar/VBoxContainer/SessionPanelFreeplay")
onready var record_panel = get_node("HBoxContainer/VBoxContainer/HBoxContainer/Toolbar/VBoxContainer/RecordPanel")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	if GameData.board_size == GameData.BoardSize.SIZE_4x4:
		make_grid(Vector2(4, 4), 0)
	elif GameData.board_size == GameData.BoardSize.SIZE_6x6:
		make_grid(Vector2(6, 6), 0)
	elif GameData.board_size == GameData.BoardSize.SIZE_8x8:
		make_grid(Vector2(8, 8), 0)
		
	for i in range(4 - GameData.difficulty):
		choose_rand_tile()
		
	$CenterOverlay/Countdown.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	session_panel.set_clicks(session_clicks)
	session_panel.set_time(session_time)
	session_panel.set_misses(session_misses)
	$TopBar/ClickCountLabel.text = str(current_clicks)
	$TopBar/TimeLabel.set_time(time_since_miss)
	
	if current_clicks >= GameData.record_clicks:
		GameData.record_clicks = current_clicks
		GameData.record_time = time_since_miss
		
	record_panel.set_clicks(GameData.record_clicks)
	record_panel.set_time(GameData.record_time)

func successful_click():
	choose_rand_tile()
	
func missed_click():
	if current_clicks == GameData.record_clicks:
		if time_since_miss < GameData.record_time:
			GameData.record_time = time_since_miss
			
func timer_timeout():
	session_time += time_passed


func _on_Countdown_countdown_finished():
	last_time = OS.get_ticks_msec()
	$Timer.start()
