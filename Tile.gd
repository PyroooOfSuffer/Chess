extends Control

@export var dark: bool = false
var setup: bool = true

var hovering = false

func _ready():
	pass


func _visual_update() -> void:
	if setup:
		if not name in global.legal_moves or not name in global.takes:
			if dark:
				$TileColor.color = global.color_dark 
			else:
				$TileColor.color = global.color_light
			$TileColor.size = global.tile_size
			setup = false
	if name in global.legal_moves:
		$TileColor.color = global.color_legal
		setup = true
	elif name in global.takes:
		$TileColor.color = global.color_takes
		setup = true


func _process(_delta):
	_visual_update()
	_selecting()


func _selecting() -> void:
	if hovering:
		if Input.is_action_just_pressed("click"):
			if not global.selected_piece.is_empty():
				global.selected_tile = name


func _on_tile_color_mouse_entered():
	hovering = true


func _on_tile_color_mouse_exited():
	hovering = false
