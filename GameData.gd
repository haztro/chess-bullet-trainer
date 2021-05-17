extends Node

enum Mode {FREEPLAY, VISION, PRECISION}
enum ChessMode {FREEPLAY, TIME, COUNTDOWN}
enum BoardSize {SIZE_4x4, SIZE_6x6, SIZE_8x8}
enum Difficulty {EASY, NORMAL, HARD, EXTREME}

const CLICK_TARGET = 5
const COUNTDOWN_TIME = 5

var white = 1
var coords = 1
var mode = 0
var chess_mode = 0
var board_size = 0
var difficulty = 0

var main_menu_scene = preload("res://Main.tscn")
var size_menu_scene = preload("res://ui/SizeMenu.tscn")
var difficulty_menu_scene = preload("res://ui/DifficultyMenu.tscn")
var chess_menu_scene = preload("res://ui/ChessMenu.tscn")

var grid_freeplay_scene = preload("res://grid/freeplay/GridFreeplay.tscn")
var grid_vision_freeplay_scene = preload("res://grid/vision/GridVision.tscn") 
var grid_vision_time_scene = preload("res://grid/vision/GridVisionTime.tscn") 
var grid_vision_countdown_scene = preload("res://grid/vision/GridVisionCountdown.tscn") 

var grid_precision_freeplay_scene = preload("res://grid/precision/GridPrecision.tscn") 
var grid_precision_time_scene = preload("res://grid/precision/GridPrecisionTime.tscn") 
var grid_precision_countdown_scene = preload("res://grid/precision/GridPrecisionCountdown.tscn") 

var record_clicks = 0
var record_time = 9999999999999999

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func start_freeplay(difficulty_selection):
	difficulty = difficulty_selection
	get_tree().change_scene_to(grid_freeplay_scene)
	
func start_vision_freeplay():
	get_tree().change_scene_to(grid_vision_freeplay_scene)
	
func start_vision_time():
	get_tree().change_scene_to(grid_vision_time_scene)
	
func start_vision_countdown():
	get_tree().change_scene_to(grid_vision_countdown_scene)
	
func start_precision_freeplay():
	get_tree().change_scene_to(grid_precision_freeplay_scene)
	
func start_precision_time():
	get_tree().change_scene_to(grid_precision_time_scene)
	
func start_precision_countdown():
	get_tree().change_scene_to(grid_precision_countdown_scene)

func goto_chess_menu(mode_selection):
	mode = mode_selection
	get_tree().change_scene_to(chess_menu_scene)

func goto_size_menu(mode_selection):
	mode = mode_selection
	get_tree().change_scene_to(size_menu_scene)
	
func goto_difficulty_menu(size_selection):
	board_size = size_selection
	get_tree().change_scene_to(difficulty_menu_scene)
	
func goto_main_menu():
	mode = 0
	board_size = 0
	difficulty = 0
	get_tree().change_scene_to(main_menu_scene)
