extends Control

@export var piece_type: String = "Queen"
@export var dark: bool = false


var selected = false


func setup_piece():
	var texture_piece = global.all_pieces.get_piece(piece_type)
	$PieceTexture.texture = texture_piece.texture_dark if dark else texture_piece.texture_light 


# Called when the node enters the scene tree for the first time.
func _ready():
	setup_piece()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	_selecting()


func _selecting():
	if selected:
		if Input.is_action_just_pressed("click"):
			print(name)



func _on_mouse_entered():
	selected = true


func _on_mouse_exited():
	selected = false
