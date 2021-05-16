extends Node

enum Pieces {KING, QUEEN, BISHOP, KNIGHT, ROOK, PAWN}


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func get_valid_moves(piece, pos):
	if piece == Pieces.PAWN:
		return get_valid_pawn_moves(pos)
	elif piece == Pieces.ROOK:
		return get_valid_rook_moves(pos)
	elif piece == Pieces.KNIGHT:
		return get_valid_knight_moves(pos)
	elif piece == Pieces.BISHOP:
		return get_valid_bishop_moves(pos)
	elif piece == Pieces.QUEEN:
		return get_valid_queen_moves(pos)
	elif piece == Pieces.KING:
		return get_valid_king_moves(pos)
	return []
		
func is_in_board(pos):
	return pos.x >= 0 and pos.x <= 7 and pos.y >= 0 and pos.y <= 7
	
func add_move(initial, pos, moves):
	if is_in_board(pos) and pos != initial:
		moves.append(pos)
	
func get_valid_pawn_moves(pos):
	var moves = []
	add_move(pos, pos + Vector2(-1, -1), moves)
#	add_move(pos, pos + Vector2(0, -1), moves)
	add_move(pos, pos + Vector2(1, -1), moves)
	
#	if pos.y == 6:
#		add_move(pos, pos + Vector2(0, -2), moves)
		
	return moves
	
func get_valid_rook_moves(pos):
	var moves = []
	for i in range(8):
		add_move(pos, Vector2(i, pos.y), moves)
	for i in range(8):
		add_move(pos, Vector2(pos.x, i), moves)
	return moves
	
func get_valid_knight_moves(pos):
	var moves = []
	add_move(pos, pos + Vector2(2, 1), moves)
	add_move(pos, pos + Vector2(2, -1), moves)
	add_move(pos, pos + Vector2(-2, 1), moves)
	add_move(pos, pos + Vector2(-2, -1), moves)
	
	add_move(pos, pos + Vector2(1, 2), moves)
	add_move(pos, pos + Vector2(1, -2), moves)
	add_move(pos, pos + Vector2(-1, 2), moves)
	add_move(pos, pos + Vector2(-1, -2), moves)
	return moves
	
func get_valid_bishop_moves(pos):
	var moves = []
	for i in range(-7, 8):
		add_move(pos, pos + Vector2(i, i), moves)
		add_move(pos, pos + Vector2(i, -i), moves)
	return moves
	
func get_valid_queen_moves(pos):
	var moves = []
	for i in range(-7, 8):
		add_move(pos, pos + Vector2(i, i), moves)
		add_move(pos, pos + Vector2(i, -i), moves)
	for i in range(8):
		add_move(pos, Vector2(i, pos.y), moves)
	for i in range(8):
		add_move(pos, Vector2(pos.x, i), moves)
	return moves
	
func get_valid_king_moves(pos):
	var moves = []
	add_move(pos, pos + Vector2(1, 1), moves)
	add_move(pos, pos + Vector2(1, -1), moves)
	add_move(pos, pos + Vector2(-1, 1), moves)
	add_move(pos, pos + Vector2(-1, -1), moves)
	add_move(pos, pos + Vector2(1, 0), moves)
	add_move(pos, pos + Vector2(0, 1), moves)
	add_move(pos, pos + Vector2(-1, 0), moves)
	add_move(pos, pos + Vector2(0, -1), moves)
	
	return moves
