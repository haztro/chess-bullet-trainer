extends Node


enum Mode {FREEPLAY, VISION, PRECISION}
enum ChessMode {FREEPLAY, TIME, COUNTDOWN}
enum BoardSize {SIZE_4x4, SIZE_6x6, SIZE_8x8}
enum Difficulty {EASY, NORMAL, HARD, EXTREME}

var mode = 0
var chess_mode = 0
var board_size = 0
var difficulty = 0

var main_menu_scene = preload("res://Main.tscn")
var size_menu_scene = preload("res://ui/SizeMenu.tscn")
var difficulty_menu_scene = preload("res://ui/DifficultyMenu.tscn")
var chess_menu_scene = preload("res://ui/ChessMenu.tscn")

var grid_freeplay_scene = preload("res://grid/GridFreePlay.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func start_freeplay(difficulty_selection):
	difficulty = difficulty_selection
	get_tree().change_scene_to(grid_freeplay_scene)

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
