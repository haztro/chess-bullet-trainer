extends Node2D

var tile_size = 100
var grid_size = Vector2.ZERO
var tiles = {}
var possible_tiles = []
var toolbar_height = 250
var letters = "ABCDEFGH"

var button_tile_scene = preload("res://grid/ButtonTile.tscn")

var last_time = 0
var current_time = 0

var streak_clicks = 0

var record_time = 99999999999999
var record_clicks = 0
var running = 0

onready var record_time_label = get_node("Toolbar/VBoxContainer/VBoxContainer6/HBoxContainer/VBoxContainer2/Label")

# Called when the node enters the scene tree for the first time.
func _ready():
	last_time = OS.get_ticks_msec()
	get_tree().get_root().connect("size_changed", self, "_on_viewport_size_changed")
	
	make_grid(Vector2(8, 8))
		
	position_board()
	
	$Countdown.start()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Label2.text = str(streak_clicks)

func _on_viewport_size_changed():
	position_board()

func position_board():
	var window_size = OS.get_window_size()
	
	tile_size = int((window_size.y * 0.8) / grid_size.y)
	for x in range(grid_size.x):
		for y in range(grid_size.y):
			tiles[Vector2(x, y)].set_new_size(Vector2(tile_size, tile_size))
			tiles[Vector2(x, y)].rect_position = Vector2(x * tile_size, y * tile_size)
	
	var board_width = grid_size.x * tile_size
	$Grid.position = Vector2((window_size.x - board_width) / 2, (window_size.y - board_width) / 2)
	$Toolbar.rect_position.y = $Grid.position.y
	$Toolbar.rect_position.x = $Grid.position.x + board_width
	$Toolbar.rect_size = Vector2((window_size.x - board_width) / 2, board_width)
	
	if $Toolbar.rect_size.x <= $Toolbar.rect_min_size.x:
		var diff = $Toolbar.rect_min_size.x - (window_size.x - $Grid.position.x - board_width)
		$Grid.position.x -= diff
		$Toolbar.rect_position.x -= diff
	
	if $Toolbar.rect_size.y <= $Toolbar.rect_min_size.y:
		$Toolbar.rect_scale = Vector2(1, 1) * board_width / $Toolbar.rect_min_size.y
	else:
		$Toolbar.rect_scale = Vector2(1, 1)
		
	$PosLabel.rect_position = Vector2($Grid.position.x + board_width / 2 - $PosLabel.rect_size.x / 2, $Grid.position.y + board_width / 2 - $PosLabel.rect_size.y / 2)
		
	$Label.rect_position.x = $Grid.position.x
	$Label.rect_position.y = $Grid.position.y / 2 - $Label.rect_size.y / 2
	
	$Label2.rect_position.x = $Grid.position.x + board_width / 2 - $Label2.rect_size.x / 2
	$Label2.rect_position.y = $Grid.position.y / 2 - $Label2.rect_size.y / 2
	
	$Label3.rect_position.x = $Grid.position.x + board_width - $Label3.rect_size.x
	$Label3.rect_position.y = $Grid.position.y / 2 - $Label3.rect_size.y / 2
	
	$Countdown.rect_position = Vector2($Grid.position.x + board_width / 2 - $Countdown.rect_size.x / 2, $Grid.position.y + board_width / 2 - $Countdown.rect_size.y / 2)
	
func show_label(value):
	$PosLabel.text = value
	$Label.text = value
	$Tween.interpolate_property($PosLabel, "modulate:a", $PosLabel.modulate.a, 1, 0.3, 0, 1)
	$Tween.start()
	yield($Tween, "tween_all_completed")
	$Tween.interpolate_property($PosLabel, "modulate:a", $PosLabel.modulate.a, 1, 0.1, 0, 1)
	$Tween.start()
	yield($Tween, "tween_all_completed")
	$Tween.interpolate_property($PosLabel, "modulate:a", $PosLabel.modulate.a, 0, 0.2, 0, 1)
	$Tween.start()
	
func choose_rand_tile():
	var rand_tile_index = int(rand_range(0, len(possible_tiles)))
	var rand_tile = possible_tiles[rand_tile_index]
	rand_tile.spawn()
	possible_tiles.erase(rand_tile)
	
	var y = letters[rand_tile.pos.x]
	var x = 8 - rand_tile.pos.y
	show_label(str(y) + str(x))

func click_registered(btn):
	if btn.safe:
		streak_clicks += 1
		AudioManager.play("click", 0, rand_range(0.3, 1.5))
		btn.safe = 0
		possible_tiles.append(btn)
		
		if streak_clicks >= 30:
			streak_clicks = 0
			if current_time < record_time:
				record_time = current_time
				record_time_label.text = get_time_string(record_time)
		
		choose_rand_tile()
	else:
		AudioManager.play("misclick", -5)
		streak_clicks = 0
		current_time = 0

func make_grid(size):
	grid_size = size
	var i = 0
	for x in range(size.x):
		for y in range(size.y):
			var bt = button_tile_scene.instance()
			tiles[Vector2(x, y)] = bt
			possible_tiles.append(bt)
			bt.pos = Vector2(x, y)
			bt.connect("button_pressed", self, "click_registered")
			bt.set_new_size(Vector2(tile_size, tile_size))
			bt.rect_position = Vector2(x * tile_size, y * tile_size)
			
			if (i+x) % 2 != 0:
				bt.colour1 = Color(0.34375, 0.225586, 0.171875)
				bt.colour2 = bt.colour1
			else:
				bt.colour1 = Color(0.953125, 0.876568, 0.778137)
				bt.colour2 = bt.colour1
			
			$Grid.add_child(bt)
			i += 1

func get_time_string(time):
	var mins = floor(time / 60000)
	var seconds = floor((time - mins * 60000) / 1000)
	var huns = time - mins * 60000 - seconds * 1000
	return "%02d:%02d:%02d" % [mins, seconds, huns / 10]

func _on_Timer_timeout():
	var time_passed = OS.get_ticks_msec() - last_time
	last_time = OS.get_ticks_msec()
	current_time += time_passed
	$Label3.text = get_time_string(current_time)


func _on_Countdown_countdown_finished():
	choose_rand_tile()
	$Timer.start()
