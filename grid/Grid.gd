extends Node2D

var tiles = {}
var possible_tiles = []
var last_time = 0
var total_time = 0
var time_since_miss = 0
var time_passed = 0


var current_clicks = 0
var session_clicks = 0
var session_misses = 0

var button_tile_scene = preload("res://grid/ButtonTile.tscn")

onready var top_margin = get_node("HBoxContainer/VBoxContainer/TopMargin")
onready var bot_margin = get_node("HBoxContainer/VBoxContainer/BotMargin")

onready var grid = get_node("HBoxContainer/VBoxContainer/HBoxContainer/Grid")
onready var top_bar = get_node("TopBar")
onready var toolbar = get_node("HBoxContainer/VBoxContainer/HBoxContainer/Toolbar")
onready var center_overlay = get_node("CenterOverlay")

# Called when the node enters the scene tree for the first time.
func _ready():
	last_time = OS.get_ticks_msec()
	get_tree().get_root().connect("size_changed", self, "_on_viewport_size_changed")
	_on_viewport_size_changed()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	grid.rect_min_size = (OS.get_window_size().y - (top_margin.rect_size.y + bot_margin.rect_size.y)) * Vector2.ONE
	grid.rect_min_size.x = max(480, grid.rect_min_size.x)
	grid.rect_min_size.y = max(480, grid.rect_min_size.y)
	
	$CenterOverlay.rect_position = grid.rect_global_position
	$CenterOverlay.rect_size = grid.rect_size
	$TopBar.rect_position = top_margin.rect_global_position + Vector2(0, 15)
	$TopBar.rect_size = Vector2(grid.rect_size.x, top_margin.rect_size.y - 15)
	
func _on_viewport_size_changed():
	$HBoxContainer.rect_size = OS.get_window_size()
	
func choose_rand_tile():
	randomize()
	var rand_tile_index = int(rand_range(0, len(possible_tiles)))
	var rand_tile = possible_tiles[rand_tile_index]
	rand_tile.spawn()
	possible_tiles.erase(rand_tile)
	
	custom_rand_tile(rand_tile)

func click_registered(btn):
	if btn.safe:
		AudioManager.play("click", 0, rand_range(0.3, 1.5))
		btn.safe = 0
		possible_tiles.append(btn)
		current_clicks += 1
		session_clicks += 1
		successful_click()
	else:
		missed_click()
		AudioManager.play("misclick", -5)
		time_since_miss = 0
		current_clicks = 0
		session_misses += 1
		
func custom_rand_tile(rand_tile):
	pass

func successful_click():
	pass
	
func missed_click():
	pass
	
func timer_timeout():
	pass
		
func make_grid(size, is_board):
	grid.columns = size.y
	
	for y in range(size.y):
		for x in range(size.x):
			var bt = button_tile_scene.instance()
			tiles[Vector2(x, y)] = bt
			possible_tiles.append(bt)
			bt.pos = Vector2(x, y)
			bt.connect("button_pressed", self, "click_registered")
			
			if is_board:
				if (x + y) % 2 != 0:
					bt.colour1 = Color(0.34375, 0.225586, 0.171875)
					bt.colour2 = bt.colour1
				else:
					bt.colour1 = Color(0.953125, 0.876568, 0.778137)
					bt.colour2 = bt.colour1
			
			grid.add_child(bt)

func _on_Timer_timeout():
	time_passed = OS.get_ticks_msec() - last_time
	last_time = OS.get_ticks_msec()
	total_time += time_passed
	time_since_miss += time_passed
	timer_timeout()
