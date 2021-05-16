extends "res://grid/Grid.gd"

var chess_tile_scene = preload("res://grid/ChessTile.tscn")
#var chess_piece_scene = preload("res://grid/Piece.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	make_grid(null, 1)	
	choose_rand_tile()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

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
		choose_rand_tile()
	else:
		AudioManager.play("misclick")

func click_registered(btn):
	AudioManager.play("misclick")

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
	
	

