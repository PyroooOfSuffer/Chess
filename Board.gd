extends Panel

@export var tile: PackedScene 
@export var piece: PackedScene

func _board_creater():
	var dark: bool = false
	for y in range(8):
		for x in range(8):
			var new_tile = tile.instantiate()
			add_child(new_tile)
			new_tile.name = str(x,y)
			new_tile.position = Vector2(x,y) * global.tile_size + global.tile_size * 0.5
			if dark:
				new_tile.dark = true
			dark = !dark
		dark = !dark


func _piece_spawner():
	for key in global.initial_position_piece.keys():
		for piece_pos in global.initial_position_piece[key]:
			var x = float(piece_pos[0])
			var y = float(piece_pos[1])
			var piece_name = key + "_" + str(piece_pos)
			
			var new_piece = piece.instantiate()
			add_child(new_piece)
			new_piece.name = piece_name
			new_piece.piece_type = key.erase(0,2)
			new_piece.dark = true if key.begins_with("D_") else false
			new_piece.position = Vector2(x,y) * global.tile_size + global.tile_size * 0.5
			
			var dict_to_add = { piece_name : piece_pos}
			global.position_piece.merge(dict_to_add, true)

func _ready():
	_board_creater()
	_piece_spawner()


func _process(_delta):
	pass
