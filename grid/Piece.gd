extends Node2D

var piece_id = 0
var white = 0

var chess = preload("res://grid/Chess.gd")

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.region_rect = Rect2(piece_id * 333, white * 333, 333, 333)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
