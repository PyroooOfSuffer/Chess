extends Node

var color_dark: Color = Color.PERU
var color_light: Color = Color.WHEAT
var tile_size: Vector2 = Vector2(60, 60)

var all_pieces: ChessPieceList = load("res://pieces/all_pieces.tres")

var selected_piece: StringName
var selected_tile: StringName

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
	"L_King" : ["47"]
}

var position_piece: Dictionary = {}

func _ready():
	pass

func _process(_delta):
	pass
