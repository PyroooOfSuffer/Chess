extends Node

@export_group("Tile_Setup")
@export var color_dark: Color = Color.PERU
@export var color_light: Color = Color.WHEAT
@export var tile_size: Vector2 = Vector2(60, 60)

@export var color_legal: Color = Color(Color.WHITE, 0.5)
@export var color_takes: Color = Color.LIGHT_PINK
@export_group("") 

var all_pieces: ChessPieceList = load("res://pieces/all_pieces.tres")

var selected_piece: StringName
var selected_tile: StringName
var legal_moves: Array[String] = []
var takes: Array[String] = []

var initial_position_piece: Dictionary = {
	"D_Pawn" : ["01","11","21","31","41","51","61","71"],
	"D_Rook" : ["00","70"],
	"D_Knight" : ["10","60"],
	"D_Bishop" : ["20","50"],
	"D_Queen" : ["30"],
	"D_King" : ["40"],
	"L_Pawn" : ["06","16","26","36","46","56","66","76"],
	"L_Rook" : ["07","77"],
	"L_Knight" : ["17","67"],
	"L_Bishop" : ["27","57"],
	"L_Queen" : ["37"],
	"L_King" : ["47"]}

var position_piece: Dictionary = {}

func _ready():
	pass

func _process(_delta):
	_get_legal_moves()

func _get_legal_moves() -> void: 
	if not selected_piece.is_empty():
		var possible_legal_moves: Array[String] = []
		var possible_takes: Array[String] = []
		var piece_type = str(selected_piece).get_slice("_",1)
		var piece_pos = position_piece[selected_piece]
		var dark = true if str(selected_piece).get_slice("_",0) == "D" else false
		
		var x = piece_pos[0]
		var y = piece_pos[1]
		
		var block_dark: Array[String] = []
		var block_light: Array[String] = []
		for key in position_piece.keys():
			var dark_block = true if str(key).get_slice("_",0) == "D" else false
			var pos_block = position_piece[key]
			if dark_block:
				block_dark.append(pos_block)
			else:
				block_light.append(pos_block)
		
		
		if piece_type == "Pawn":
			var move_direction = 1 if dark else -1
			var start_pos = piece_pos in initial_position_piece["D_Pawn"] if dark else piece_pos in initial_position_piece["L_Pawn"]
			
			if start_pos:
				for dy in range(1,3):
					var new_move = str(x, int(y) + move_direction * dy)
					if new_move in block_dark or new_move in block_light:
						break
					else:
						possible_legal_moves.append(new_move)
			else:
				var new_move = str(x, int(y) + move_direction)
				if new_move not in block_dark and new_move not in block_light:
					possible_legal_moves.append(new_move)
		elif piece_type == "Rook":
			if dark:  # DARK ROOK ----------------------------------------
				for direction in [Vector2(0,1),Vector2(0,-1),Vector2(1,0),Vector2(-1,0)]:
					var dx = direction.x
					var dy = direction.y
					for d in range(1, 8):
						var new_move = str(int(x) + d * dx, int(y) + d * dy)
						if new_move in block_dark:
							break
						elif new_move in block_light:
							possible_takes.append(new_move)
							break
						else:
							possible_legal_moves.append(new_move)
			else:  # LIGHT ROOK ----------------------------------------
				for direction in [Vector2(0,1),Vector2(0,-1),Vector2(1,0),Vector2(-1,0)]:
					var dx = direction.x
					var dy = direction.y
					for d in range(1, 8):
						var new_move = str(int(x) + d * dx, int(y) + d * dy)
						if new_move in block_light:
							break
						elif new_move in block_dark:
							possible_takes.append(new_move)
							break
						else:
							possible_legal_moves.append(new_move)
		elif piece_type == "Knight":
			if dark:  # DARK KNIGHT ----------------------------------------
				var moves = [
					Vector2(2,1),Vector2(2, -1),Vector2(-2,1),Vector2(-2,-1),
					Vector2(1,2),Vector2(-1, 2),Vector2(1,-2),Vector2(-1,-2)
				]
				for d in moves:
					var dx = d.x
					var dy = d.y
					var new_move = str(int(x) + dx, int(y) + dy)
					if new_move in block_light:
						possible_takes.append(new_move)
					elif not new_move in block_dark:
						possible_legal_moves.append(new_move)
			else:  # LIGHT KNIGHT ----------------------------------------
				var moves = [
					Vector2(2,1),Vector2(2, -1),Vector2(-2,1),Vector2(-2,-1),
					Vector2(1,2),Vector2(-1, 2),Vector2(1,-2),Vector2(-1,-2)
				]
				for d in moves:
					var dx = d.x
					var dy = d.y
					var new_move = str(int(x) + dx, int(y) + dy)
					if new_move in block_dark:
						possible_takes.append(new_move)
					elif not new_move in block_light:
						possible_legal_moves.append(new_move)
		elif piece_type == "Bishop":
			if dark:  # DARK BISHOP ----------------------------------------
				for direction in [Vector2(1,1),Vector2(-1,-1),Vector2(1,-1),Vector2(-1,1)]:
					var dx = direction.x
					var dy = direction.y
					for d in range(1, 8):
						var new_move = str(int(x) + d * dx, int(y) + d * dy)
						if new_move in block_dark:
							break
						elif new_move in block_light:
							possible_takes.append(new_move)
							break
						else:
							possible_legal_moves.append(new_move)
			else:  # LIGHT BISHOP ----------------------------------------
				for direction in [Vector2(1,1),Vector2(-1,-1),Vector2(1,-1),Vector2(-1,1)]:
					var dx = direction.x
					var dy = direction.y
					for d in range(1, 8):
						var new_move = str(int(x) + d * dx, int(y) + d * dy)
						if new_move in block_light:
							break
						elif new_move in block_dark:
							possible_takes.append(new_move)
							break
						else:
							possible_legal_moves.append(new_move)
		elif piece_type == "Queen":
			if dark:  # DARK QUEEN ----------------------------------------
				for direction in [
						Vector2(1,1),Vector2(-1,-1),Vector2(1,-1),Vector2(-1,1),
						Vector2(0,1),Vector2(0,-1),Vector2(1,0),Vector2(-1,0)]:
					var dx = direction.x
					var dy = direction.y
					for d in range(1, 8):
						var new_move = str(int(x) + d * dx, int(y) + d * dy)
						if new_move in block_dark:
							break
						elif new_move in block_light:
							possible_takes.append(new_move)
							break
						else:
							possible_legal_moves.append(new_move)
			else:  # LIGHT QUEEN ----------------------------------------
				for direction in [
						Vector2(1,1),Vector2(-1,-1),Vector2(1,-1),Vector2(-1,1),
						Vector2(0,1),Vector2(0,-1),Vector2(1,0),Vector2(-1,0)]:
					var dx = direction.x
					var dy = direction.y
					for d in range(1, 8):
						var new_move = str(int(x) + d * dx, int(y) + d * dy)
						if new_move in block_light:
							break
						elif new_move in block_dark:
							possible_takes.append(new_move)
							break
						else:
							possible_legal_moves.append(new_move)
		elif piece_type == "King":
			if dark:  # DARK KING ----------------------------------------
				var moves = [
					Vector2(1,1),Vector2(-1,-1),Vector2(1,-1),Vector2(-1,1),
					Vector2(0,1),Vector2(0,-1),Vector2(1,0),Vector2(-1,0)
				]
				for d in moves:
					var dx = d.x
					var dy = d.y
					var new_move = str(int(x) + dx, int(y) + dy)
					if new_move in block_light:
						possible_takes.append(new_move)
					elif not new_move in block_dark:
						possible_legal_moves.append(new_move)
			else:  # LIGHT KING ----------------------------------------
				var moves = [
					Vector2(1,1),Vector2(-1,-1),Vector2(1,-1),Vector2(-1,1),
					Vector2(0,1),Vector2(0,-1),Vector2(1,0),Vector2(-1,0)
				]
				for d in moves:
					var dx = d.x
					var dy = d.y
					var new_move = str(int(x) + dx, int(y) + dy)
					if new_move in block_dark:
						possible_takes.append(new_move)
					elif not new_move in block_light:
						possible_legal_moves.append(new_move)
		
		legal_moves = possible_legal_moves
		takes = possible_takes
	
