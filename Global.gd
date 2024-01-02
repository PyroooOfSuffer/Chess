extends Node

@export_group("Tile_Setup")
@export var color_dark: Color = Color.PERU
@export var color_light: Color = Color.WHEAT
@export var tile_size: Vector2 = Vector2(60, 60)

@export var color_legal: Color = Color.AQUA
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
			if dark:  # DARK PAWN ----------------------------------------
				if piece_pos in initial_position_piece["D_Pawn"]:
					for dy in range(2):
						var new_move = str(x,int(y)+dy+1)
						if new_move in block_dark:
							break
						elif new_move in block_light:
							possible_takes.append(new_move)
							break
						else:
							possible_legal_moves.append(new_move)
				else:
					var new_move = str(x,int(y)+1)
					if new_move in block_dark:
						pass
					elif new_move in block_light:
						possible_takes.append(new_move)
					else:
						possible_legal_moves.append(new_move)
			else:  # LIGHT PAWN ----------------------------------------
				if piece_pos in initial_position_piece["L_Pawn"]:
					for dy in range(2):
						var new_move = str(x,int(y)-dy-1)
						if new_move in block_light:
							break
						elif new_move in block_dark:
							possible_takes.append(new_move)
							break
						else:
							possible_legal_moves.append(new_move)
				else:
					var new_move = str(x,int(y)-1)
					if new_move in block_light:
						pass
					elif new_move in block_dark:
						possible_takes.append(new_move)
					else:
						possible_legal_moves.append(new_move)
		elif piece_type == "Rook":
			if dark:  # DARK ROOK ----------------------------------------
				for dy in range(8):
					var new_move = str(x,int(y)+dy+1)
					if new_move in block_dark:
						break
					elif new_move in block_light:
						possible_takes.append(new_move)
						break
					else:
						possible_legal_moves.append(new_move)
					new_move = str(x,int(y)-dy-1)
					if new_move in block_dark:
						break
					elif new_move in block_light:
						possible_takes.append(new_move)
						break
					else:
						possible_legal_moves.append(new_move)
				for dx in range(8):
					var new_move = str(int(x)+dx+1,y)
					if new_move in block_dark:
						break
					elif new_move in block_light:
						possible_takes.append(new_move)
						break
					else:
						possible_legal_moves.append(new_move)
					new_move = str(int(x)-dx-1,y)
					if new_move in block_dark:
						break
					elif new_move in block_light:
						possible_takes.append(new_move)
						break
					else:
						possible_legal_moves.append(new_move)
			else:  # LIGHT ROOK ----------------------------------------
				for dy in range(8):
					var new_move = str(x,int(y)+dy+1)
					if new_move in block_light:
						break
					elif new_move in block_dark:
						possible_takes.append(new_move)
						break
					else:
						possible_legal_moves.append(new_move)
					new_move = str(x,int(y)-dy-1)
					if new_move in block_light:
						break
					elif new_move in block_dark:
						possible_takes.append(new_move)
						break
					else:
						possible_legal_moves.append(new_move)
				for dx in range(8):
					var new_move = str(int(x)+dx+1,y)
					if new_move in block_light:
						break
					elif new_move in block_dark:
						possible_takes.append(new_move)
						break
					else:
						possible_legal_moves.append(new_move)
					new_move = str(int(x)-dx-1,y)
					if new_move in block_light:
						break
					elif new_move in block_dark:
						possible_takes.append(new_move)
						break
					else:
						possible_legal_moves.append(new_move)
		elif piece_type == "Knight":
			pass
		elif piece_type == "Bishop":
			pass
		elif piece_type == "Queen":
			pass
		elif piece_type == "King":
			pass 
		
		legal_moves = possible_legal_moves
		takes = possible_takes
