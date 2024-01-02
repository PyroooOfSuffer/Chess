extends Resource

class_name ChessPieceList

@export var AllPieces: Array[ChessPiece]

func check_name(piece: ChessPiece, name: String) -> bool:
	print("Comparing %s with %s" % [piece.piece_name, name])
	return piece.piece_name == name

func get_piece(name: String) -> ChessPiece:
	var pieces = AllPieces.filter(func(x: ChessPiece): return check_name(x, name))
	return pieces[0]
