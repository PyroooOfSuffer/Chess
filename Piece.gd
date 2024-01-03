extends Control

@export var piece_type: String = "Queen"
@export var dark: bool = false
var setup: bool = true

@export var piece_position: String
var hovering = false


func _ready():
	pass


func _visual_update() -> void:
	if setup:
		var texture_piece = global.all_pieces.get_piece(piece_type)
		$PieceTexture.texture = texture_piece.texture_dark if dark else texture_piece.texture_light
		setup = false


func _process(delta):
	_visual_update()
	_get_position()
	_selecting(delta)


func _get_position():
	piece_position = global.position_piece[str(name)]

func _selecting(delta) -> void:
	if hovering:
		if Input.is_action_just_pressed("click"):
			if global.selected_piece.is_empty(): 
				global.selected_piece = name
				global.legal_moves = []
				global.takes = []
			elif piece_position in global.takes: # u get taked
				global.selected_tile = piece_position 
				queue_free() # die
	if name == global.selected_piece:
		$PieceTexture.scale = Vector2(1.02,1.02)
		if not global.selected_tile.is_empty():
			if global.selected_tile in global.legal_moves or global.selected_tile in global.takes:
				var x = float(str(global.selected_tile)[0])
				var y = float(str(global.selected_tile)[1])
				position = Vector2(x,y) * global.tile_size + global.tile_size * 0.5
				
				global.selected_tile = StringName()
				global.selected_piece = StringName()
				global.legal_moves = []
				global.takes = []
			
				var dict_to_add = { name : str(x,y)}
				global.position_piece.merge(dict_to_add, true)
			else:
				global.selected_tile = StringName()
				global.selected_piece = StringName()
				global.legal_moves = []
				global.takes = []


func _on_mouse_entered():
	hovering = true
	if global.selected_piece.is_empty():
		$PieceTexture.scale = Vector2(1.02,1.02)


func _on_mouse_exited():
	hovering = false
	$PieceTexture.scale = Vector2(1,1)
