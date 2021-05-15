extends Node2D

var tile_size = 100
var grid_size = Vector2.ZERO
var tiles = {}
var possible_tiles = []
var toolbar_height = 250

var last_time = 0
var streak_time = 0
var streak_clicks = 0

var session_time = 0
var session_clicks = 0
var session_misses = 0

var record_time = 0
var record_clicks = 0

var button_tile_scene = preload("res://grid/ButtonTile.tscn")

onready var streak_time_label = get_node("Toolbar/VBoxContainer/VBoxContainer4/HBoxContainer/VBoxContainer2/Label")
onready var streak_clicks_label = get_node("Toolbar/VBoxContainer/VBoxContainer4/HBoxContainer/VBoxContainer2/Label2")

onready var session_time_label = get_node("Toolbar/VBoxContainer/VBoxContainer5/HBoxContainer/VBoxContainer2/Label")
onready var session_clicks_label = get_node("Toolbar/VBoxContainer/VBoxContainer5/HBoxContainer/VBoxContainer2/Label2")
onready var session_misses_label = get_node("Toolbar/VBoxContainer/VBoxContainer5/HBoxContainer/VBoxContainer2/Label3")

onready var record_time_label = get_node("Toolbar/VBoxContainer/VBoxContainer6/HBoxContainer/VBoxContainer2/Label")
onready var record_clicks_label = get_node("Toolbar/VBoxContainer/VBoxContainer6/HBoxContainer/VBoxContainer2/Label2")

# Called when the node enters the scene tree for the first time.
func _ready():
	last_time = OS.get_ticks_msec()
	get_tree().get_root().connect("size_changed", self, "_on_viewport_size_changed")
	
	if GameData.board_size == GameData.BoardSize.SIZE_4x4:
		make_grid(Vector2(4, 4))
	elif GameData.board_size == GameData.BoardSize.SIZE_6x6:
		make_grid(Vector2(6, 6))
	elif GameData.board_size == GameData.BoardSize.SIZE_8x8:
		make_grid(Vector2(8, 8))
		
	for i in range(4 - GameData.difficulty):
		choose_rand_tile()
		
	position_board()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Label.text = streak_clicks_label.text

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
		
	$Label.rect_position.x = $Grid.position.x + board_width / 2 - $Label.rect_size.x / 2
	$Label.rect_position.y = $Grid.position.y / 2 - $Label.rect_size.y / 2
	
func choose_rand_tile():
	var rand_tile_index = int(rand_range(0, len(possible_tiles)))
	var rand_tile = possible_tiles[rand_tile_index]
	rand_tile.spawn()
	possible_tiles.erase(rand_tile)

func click_registered(btn):
	if btn.safe:
		update_click_labels_hit()
		AudioManager.play("click", 0, rand_range(0.3, 1.5))
		btn.safe = 0
		possible_tiles.append(btn)
		choose_rand_tile()
	else:
		AudioManager.play("misclick", -5)
		
		if streak_clicks > record_clicks:
			record_clicks = streak_clicks
			record_time = streak_time
		elif streak_clicks == record_clicks and streak_time < record_time:
			record_time = streak_time
		
		update_click_labels_miss()
		
func update_click_labels_hit():
	streak_clicks += 1
	session_clicks += 1
	streak_clicks_label.text = str(streak_clicks)
	session_clicks_label.text = str(session_clicks)
	
func update_click_labels_miss():
	streak_clicks = 0
	streak_time = 0
	session_misses += 1
	
	session_misses_label.text = str(session_misses)
	streak_clicks_label.text = str(streak_clicks)
	record_clicks_label.text = str(record_clicks)
	record_time_label.text = get_time_string(record_time)

func make_grid(size):
	grid_size = size
	for x in range(size.x):
		for y in range(size.y):
			var bt = button_tile_scene.instance()
			tiles[Vector2(x, y)] = bt
			possible_tiles.append(bt)
			bt.pos = Vector2(x, y)
			bt.connect("button_pressed", self, "click_registered")
			bt.set_new_size(Vector2(tile_size, tile_size))
			bt.rect_position = Vector2(x * tile_size, y * tile_size)
			$Grid.add_child(bt)

func get_time_string(time):
	var mins = floor(time / 60000)
	var seconds = floor((time - mins * 60000) / 1000)
	var huns = time - mins * 60000 - seconds * 1000
	return "%02d:%02d:%02d" % [mins, seconds, huns / 10]

func _on_Timer_timeout():
	var time_passed = OS.get_ticks_msec() - last_time
	last_time = OS.get_ticks_msec()
	streak_time += time_passed
	session_time += time_passed
	streak_time_label.text = get_time_string(streak_time)
	session_time_label.text = get_time_string(session_time)
