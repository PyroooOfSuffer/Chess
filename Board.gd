extends Node2D

@export var tile: PackedScene 

func _board_creater():
	var dark: bool = false
	for y in range(8):
		for x in range(8):
			var new_tile = tile.instantiate()
			add_child(new_tile)
			new_tile.name = str(x,y)  # how to reuse
			new_tile.position = Vector2(x,y) * global.tile_size + global.tile_size * 0.5
			if dark:
				new_tile.dark = true
			dark = !dark
		dark = !dark

# Called when the node enters the scene tree for the first time.
func _ready():
	_board_creater()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
