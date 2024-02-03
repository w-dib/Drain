extends Node2D

var grid_size = Vector2(6, 4) # Grid dimensions
var cell_size = Vector2(244, 244) # Size of each cell in pixels

var pipe_scenes = [
	preload("res://scenes/pipes/pipebend.tscn"), 
	preload("res://scenes/pipes/pipebend.tscn"), 
	preload("res://scenes/pipes/pipecross.tscn"), 
	preload("res://scenes/pipes/pipestraight.tscn"),
	preload("res://scenes/pipes/pipestraight.tscn"), 
	preload("res://scenes/pipes/pipetshape.tscn")
	]

func _ready() -> void:
	for x in range(grid_size.x):
		for y in range(grid_size.y):
			spawn_random_pipe(Vector2(x,y))

func _draw() -> void:
	for x in range(grid_size.x):
		for y in range(grid_size.y):
			var cell_position = Vector2(x, y) * cell_size
			draw_rect(Rect2(cell_position, cell_size), Color(0.5, 0.5, 0.5, 1), false)

func spawn_random_pipe(cell_position: Vector2) -> void:
	var random_scene: PackedScene = pipe_scenes[randi() % pipe_scenes.size()]
	var instance = random_scene.instantiate()
	instance.position = (cell_position * cell_size) + cell_size/2
	add_child(instance)
