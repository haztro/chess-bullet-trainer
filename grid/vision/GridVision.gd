extends "res://grid/Grid.gd"

var session_time = 0

var letters = "ABCDEFGH"
var target = ""

onready var session_panel = get_node("HBoxContainer/VBoxContainer/HBoxContainer/Toolbar/VBoxContainer/SessionPanelFreeplay")
onready var record_panel = get_node("HBoxContainer/VBoxContainer/HBoxContainer/Toolbar/VBoxContainer/RecordPanel")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	make_grid(Vector2(8, 8), 1)
		
	$CenterOverlay/Countdown.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	session_panel.set_clicks(session_clicks)
	session_panel.set_time(session_time)
	session_panel.set_misses(session_misses)
	$TopBar/TargetLabel.text = target
	$TopBar/ClickCountLabel.text = str(current_clicks)
	$TopBar/TimeLabel.set_time(time_since_miss)
	
	check_record()

func check_record():
	if current_clicks >= GameData.record_clicks:
		GameData.record_clicks = current_clicks
		GameData.record_time = time_since_miss
		
	record_panel.set_clicks(GameData.record_clicks)
	record_panel.set_time(GameData.record_time)
		
func check_record_time():
	if current_clicks == GameData.record_clicks:
		if time_since_miss < GameData.record_time:
			GameData.record_time = time_since_miss
			
func custom_rand_tile(rand_tile):
	var y = letters[rand_tile.pos.x]
	var x = 8 - rand_tile.pos.y
	target = str(y) + str(x)
	$CenterOverlay/PromptLabel.show_label(target)

func successful_click():
	choose_rand_tile()
	
func missed_click():
	check_record_time()
	
func custom_start():
	pass
			
func timer_timeout():
	session_time += time_passed

func _on_Countdown_countdown_finished():
	custom_start()	
	last_time = OS.get_ticks_msec()
	$Timer.start()
	choose_rand_tile()
	
