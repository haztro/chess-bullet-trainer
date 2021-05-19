extends "res://grid/Grid.gd"

var session_time = 0

var letters = "ABCDEFGH"
var target = "  "
var target_pos = Vector2.ZERO

var chess_tile_scene = preload("res://grid/ChessTile.tscn")

onready var session_panel = get_node("Toolbar/VBoxContainer/SessionPanelFreeplay")
onready var record_panel = get_node("Toolbar/VBoxContainer/RecordPanel")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	make_grid(Vector2(8, 8), 1)
		
	$CenterOverlay/Countdown.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	session_panel.set_clicks(session_clicks)
	session_panel.set_time(get_time_string(session_time))
	session_panel.set_misses(session_misses)
	session_panel.set_accuracy(accuracy)
	update_top_bar_labels()
	
	custom_record()
	
	var c = get_closest_tile()
	c.get_node("Panel").visible = 1
	
func custom_record():
	record_panel.set_clicks(GameData.score["vision"]["freeplay"]["clicks"])
	record_panel.set_time(get_time_string(GameData.score["vision"]["freeplay"]["time"]))

func get_closest_tile():
	var min_dis = 9999999
	var closest = null
	# Get closest 
	for t in tiles.values():
		t.get_node("Panel").visible = 0
		var d = get_global_mouse_position().distance_to(t.rect_global_position + t.rect_size/2)
		if d < min_dis:
			min_dis = d
			closest = t
			
	return closest	

func update_top_bar_labels():
	$TopBar/TargetLabel.text = target
	$TopBar/ClickCountLabel.text = str(current_clicks)
	$TopBar/TimeLabel.text = get_time_string(time_since_miss, time_since_miss >= 60000)

func check_record():
	if current_clicks >= GameData.score["vision"]["freeplay"]["clicks"]:
		GameData.score["vision"]["freeplay"]["clicks"] = current_clicks
		GameData.score["vision"]["freeplay"]["time"] = time_since_miss
		
func check_record_time():
	if current_clicks == GameData.score["vision"]["freeplay"]["clicks"]:
		if time_since_miss < GameData.score["vision"]["freeplay"]["time"]:
			GameData.score["vision"]["freeplay"]["time"] = time_since_miss
			
func custom_rand_tile(rand_tile):
	target_pos = rand_tile.pos
	var x
	var y
	if GameData.white:
		y = letters[rand_tile.pos.x]
		x = 8 - rand_tile.pos.y
	else:
		y = letters[7 - rand_tile.pos.x]
		x = rand_tile.pos.y + 1
		
	target = str(y) + str(x)
	$CenterOverlay/PromptLabel.show_label(target)

func successful_click():
	choose_rand_tile()
	
func missed_click():
	check_record()
	check_record_time()
	
func make_grid(size, chess):
	grid.columns = 8
	
	for y in range(8):
		for x in range(8):
			var bt = chess_tile_scene.instance()
			tiles[Vector2(x, y)] = bt
			possible_tiles.append(bt)
			bt.pos = Vector2(x, y)
			bt.connect("button_pressed", self, "click_registered")
			
			if (x + y) % 2 != 0:
				bt.colour1 = Color(0.34375, 0.225586, 0.171875)
				bt.colour2 = bt.colour1
			else:
				bt.colour1 = Color(0.953125, 0.876568, 0.778137)
				bt.colour2 = bt.colour1
			
			grid.add_child(bt)
	
func custom_start():
	pass
			
func timer_timeout():
	session_time += time_passed

func _on_Countdown_countdown_finished():
	custom_start()	
	last_time = OS.get_ticks_msec()
	$Timer.start()
	choose_rand_tile()
	

func _on_ChessSettings_colour_changed():
	var new_pos = Vector2(7 - target_pos.x, 7 - target_pos.y)
	tiles[target_pos].safe = 0
	possible_tiles.append(tiles[target_pos])
	tiles[new_pos].spawn()
	possible_tiles.erase(tiles[new_pos])
