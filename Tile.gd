extends Control

@export var dark: bool = false

var selected = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	_visual_update()
	_selecting()

func _visual_update() -> void:
	if dark:
		$TileColor.color = global.color_dark 
	else:
		$TileColor.color = global.color_light
	$TileColor.size = global.tile_size

func _selecting():
	if selected:
		if Input.is_action_just_pressed("click"):
			print(name)


func _on_tile_color_mouse_entered():
	selected = true


func _on_tile_color_mouse_exited():
	selected = false
