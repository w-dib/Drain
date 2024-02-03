extends Node2D

var grid_size = Vector2(6, 4) # Grid dimensions
var cell_size = Vector2(244, 244) # Size of each cell in pixels

func _draw():
	for x in range(grid_size.x):
		for y in range(grid_size.y):
			var cell_position = Vector2(x, y) * cell_size
			draw_rect(Rect2(cell_position, cell_size), Color(0.5, 0.5, 0.5, 1), false)
