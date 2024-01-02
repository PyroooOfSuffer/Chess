extends Node

var color_dark: Color = Color.DARK_OLIVE_GREEN
var color_light: Color = Color.DARK_GREEN
var tile_size: Vector2 = Vector2(60, 60)

var all_pieces: ChessPieceList = load("res://pieces/all_pieces.tres")

var selcted_tile
var selceted_piece

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
