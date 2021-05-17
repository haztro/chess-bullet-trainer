extends "res://grid/Grid.gd"


var session_time = 0

var chess_tile_scene = preload("res://grid/ChessTile.tscn")

onready var session_panel = get_node("HBoxContainer/VBoxContainer/HBoxContainer/Toolbar/VBoxContainer/SessionPanelFreeplay")
onready var record_panel = get_node("HBoxContainer/VBoxContainer/HBoxContainer/Toolbar/VBoxContainer/RecordPanel")


# Called when the node enters the scene tree for the first time.
func _ready():
	make_grid(null, 1)	
#	choose_rand_tile()
	
	$CenterOverlay/Countdown.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	session_panel.set_clicks(session_clicks)
	session_panel.set_time(get_time_string(session_time))
	session_panel.set_misses(session_misses)
	update_top_bar_labels()
	check_record()

func update_top_bar_labels():
#	$TopBar/TargetLabel.text = target
	$TopBar/ClickCountLabel.text = str(current_clicks)
	$TopBar/TimeLabel.text = get_time_string(time_since_miss)
	
func check_record():
	if current_clicks >= GameData.record_clicks:
		GameData.record_clicks = current_clicks
		GameData.record_time = time_since_miss
		
	record_panel.set_clicks(GameData.record_clicks)
	record_panel.set_time(get_time_string(GameData.record_time))
		
func check_record_time():
	if current_clicks == GameData.record_clicks:
		if time_since_miss < GameData.record_time:
			GameData.record_time = time_since_miss

func choose_rand_tile():
	randomize()
	var rand_tile_index = int(rand_range(0, 64))
	var y = int(rand_tile_index / 8)
	var x = int(rand_tile_index % 8)
	var rand_tile = tiles[Vector2(x, y)]
	rand_tile.spawn()
	
	$ActivePiece.set_piece_type(Vector2(x, y), 0)
	$ActivePiece.start_square = rand_tile
	$ActivePiece.position = rand_tile.rect_global_position
	
	var valid_moves = Chess.get_valid_moves($ActivePiece.piece_id, $ActivePiece.start_square.pos)
	$ActivePiece.target_square = tiles[valid_moves[int(rand_range(0, len(valid_moves)))]]

	$TakePiece.set_piece_type($ActivePiece.target_square.pos, 1)
	$TakePiece.start_square = $ActivePiece.target_square
	$TakePiece.position = $TakePiece.start_square.rect_global_position
	
#	for pos in Chess.get_valid_moves(p.piece_id, p.start_square.pos):
#		tiles[pos].get_node("ColorRect").color = Color(0, 0, 0, 1)
func _on_ActivePiece_released(piece):
	var min_dis = 9999999
	var closest = null
	
	# Get closest 
	for t in tiles.values():
		var d = piece.position.distance_to(t.rect_global_position)
		if d < min_dis:
			min_dis = d
			closest = t
	
	if closest == $ActivePiece.target_square:
		
		AudioManager.play("click")
		piece.start_square = closest
		piece.position = closest.rect_global_position
		custom_success()
		
	else:
		misclick()
		
func disable_pieces():
	$TakePiece.get_node("Button").disabled = 1
	$ActivePiece.get_node("Button").disabled = 1
	
func enable_pieces():
	$TakePiece.get_node("Button").disabled = 0
	$ActivePiece.get_node("Button").disabled = 0
	
func hide_pieces():
	$TakePiece.visible = 0
	$ActivePiece.visible = 0
	
func show_pieces():
	$TakePiece.visible = 1
	$ActivePiece.visible = 1
	
func custom_success():
	choose_rand_tile()
	current_clicks += 1
	session_clicks += 1
	
func custom_misclick():
	pass
		
func misclick():
	custom_misclick()
#	hide_pieces()
	current_clicks = 0
	time_since_miss = 0
	session_misses += 1
	$ActivePiece.is_grabbed = 0
	AudioManager.play("misclick")

# Overriding function so need to update currneet clicks
func click_registered(btn):
	misclick()
	check_record()
	
func custom_start():
	pass

func make_grid(size, chess):
	grid.columns = 8
	
	for y in range(8):
		for x in range(8):
			var bt = chess_tile_scene.instance()
			tiles[Vector2(x, y)] = bt
			bt.pos = Vector2(x, y)
			bt.connect("button_pressed", self, "click_registered")
			
			if (x + y) % 2 != 0:
				bt.colour1 = Color(0.34375, 0.225586, 0.171875)
				bt.colour2 = bt.colour1
			else:
				bt.colour1 = Color(0.953125, 0.876568, 0.778137)
				bt.colour2 = bt.colour1
			
			grid.add_child(bt)

func timer_timeout():
	session_time += time_passed
	
func _on_Countdown_countdown_finished():
	custom_start()	
	last_time = OS.get_ticks_msec()
	$Timer.start()
	choose_rand_tile()
