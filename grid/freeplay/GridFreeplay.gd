extends "res://grid/Grid.gd"

var session_time = 0

onready var session_panel = get_node("Toolbar/VBoxContainer/SessionPanelFreeplay")
onready var record_panel = get_node("Toolbar/VBoxContainer/RecordPanel")

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
	session_panel.set_time(get_time_string(session_time))
	session_panel.set_misses(session_misses)
	session_panel.set_accuracy(accuracy)
	$TopBar/ClickCountLabel.text = str(current_clicks)
	$TopBar/TimeLabel.text = get_time_string(time_since_miss, time_since_miss >= 60000)
		
	record_panel.set_clicks(GameData.score["freeplay"][GameData.difficulties[GameData.difficulty]][GameData.board_sizes[GameData.board_size]]["clicks"])
	record_panel.set_time(get_time_string(GameData.score["freeplay"][GameData.difficulties[GameData.difficulty]][GameData.board_sizes[GameData.board_size]]["time"]))

func successful_click():
	choose_rand_tile()
	
func missed_click():
	if current_clicks >= GameData.score["freeplay"][GameData.difficulties[GameData.difficulty]][GameData.board_sizes[GameData.board_size]]["clicks"]:
		GameData.score["freeplay"][GameData.difficulties[GameData.difficulty]][GameData.board_sizes[GameData.board_size]]["clicks"] = current_clicks
		GameData.score["freeplay"][GameData.difficulties[GameData.difficulty]][GameData.board_sizes[GameData.board_size]]["time"] = time_since_miss	

	if current_clicks == GameData.score["freeplay"][GameData.difficulties[GameData.difficulty]][GameData.board_sizes[GameData.board_size]]["clicks"]:
		if time_since_miss < GameData.score["freeplay"][GameData.difficulties[GameData.difficulty]][GameData.board_sizes[GameData.board_size]]["time"]:
			GameData.score["freeplay"][GameData.difficulties[GameData.difficulty]][GameData.board_sizes[GameData.board_size]]["time"] = time_since_miss
			
func timer_timeout():
	session_time += time_passed


func _on_Countdown_countdown_finished():
	last_time = OS.get_ticks_msec()
	$Timer.start()
