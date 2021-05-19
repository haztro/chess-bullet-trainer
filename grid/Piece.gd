extends Node2D

signal released(piece)
signal clicked(piece)


export(int) var active = 1

var piece_id = 0
var white = 0
var start_square = null
var target_square = null

var is_grabbed = 0

# Called when the node enters the scene tree for the first time.
func _ready():
#	if !active:
#	$Button.mouse_filter = Control.MOUSE_FILTER_IGNORE
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if start_square != null:
		if active:
			$Sprite.region_rect = Rect2(piece_id * 333, (GameData.white ^ 1) * 333, 333, 333)
		else:
			$Sprite.region_rect = Rect2(piece_id * 333, GameData.white * 333, 333, 333)

		$Sprite.scale = start_square.rect_size / 333
		$Button.rect_size = start_square.rect_size
		position = start_square.rect_global_position
	
	if is_grabbed:
		position = get_global_mouse_position() - $Button.rect_size / 2
	
func set_piece_type(pos, is_target):
	var min_bound = 0
	if is_target:
		min_bound = 1
	if pos.y == 0 or pos.y == 7:
		piece_id = int(rand_range(min_bound, 5))
	else:
		piece_id = int(rand_range(min_bound, 6))
	if active == 0:
		white = 1
	$Sprite.region_rect = Rect2(piece_id * 333, white * 333, 333, 333)

func _on_Button_button_down():
	if active:
		start_square.get_node("ColorRect2").visible = 1
		is_grabbed = 1
	else:
		emit_signal("clicked", self)


func _on_Button_button_up():
	if active:
		is_grabbed = 0
		emit_signal("released", self)
