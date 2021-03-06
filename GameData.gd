extends Node

enum Mode {FREEPLAY, VISION, PRECISION}
enum ChessMode {FREEPLAY, TIME, COUNTDOWN}
enum BoardSize {SIZE_4x4, SIZE_6x6, SIZE_8x8}
enum Difficulty {EASY, NORMAL, HARD, EXTREME}

const difficulties = {Difficulty.EASY : "easy", Difficulty.NORMAL : "normal", Difficulty.HARD : "hard", Difficulty.EXTREME : "extreme"}
const board_sizes = {BoardSize.SIZE_4x4 : "4x4", BoardSize.SIZE_6x6 : "6x6", BoardSize.SIZE_8x8 : "8x8"}

const CLICK_TARGET = 29
const COUNTDOWN_TIME = 30

var white = 1
var coords = 1
var mode = 0
var chess_mode = 0
var board_size = 0
var difficulty = 0
var score = {"freeplay" : {"easy" : 
								{"8x8" : {"clicks":0, "time":0}, 
								"6x6" : {"clicks":0, "time":0}, 
								"4x4" : {"clicks":0, "time":0}}, 
							"normal" : 
								{"8x8" : {"clicks":0, "time":0}, 
								"6x6" : {"clicks":0, "time":0}, 
								"4x4" : {"clicks":0, "time":0}}, 
							"hard" :
								{"8x8" : {"clicks":0, "time":0}, 
								"6x6" : {"clicks":0, "time":0}, 
								"4x4" : {"clicks":0, "time":0}}, 
							"extreme" : 
								{"8x8" : {"clicks":0, "time":0}, 
								"6x6" : {"clicks":0, "time":0}, 
								"4x4" : {"clicks":0, "time":0}}}, 
			"vision" : 
				{"freeplay" : {"clicks":0, "time":0}, 
				"time" : {"clicks":0, "time":99999999999}, 
				"countdown" : {"clicks":0, "time":COUNTDOWN_TIME*1000}}, 
			"precision" : 
				{"freeplay" : {"clicks":0, "time":0}, 
				"time" : {"clicks":0, "time":99999999999}, 
				"countdown" : {"clicks":0, "time":COUNTDOWN_TIME*1000}}}

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
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
	if Input.is_action_just_pressed("mute"):
		AudioManager.toggle_mute()

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
