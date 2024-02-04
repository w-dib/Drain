extends Node2D

var grid_size = Vector2(6, 4)
var cell_size = Vector2(244, 244)

var pipe_scenes = [
#9x
	preload("res://scenes/pipes/pipebend.tscn"), 
	preload("res://scenes/pipes/pipebend.tscn"), 
	preload("res://scenes/pipes/pipebend.tscn"), 
	preload("res://scenes/pipes/pipebend.tscn"),
	preload("res://scenes/pipes/pipebend.tscn"),
	preload("res://scenes/pipes/pipebend.tscn"),
	preload("res://scenes/pipes/pipebend.tscn"),
	preload("res://scenes/pipes/pipebend.tscn"),
	preload("res://scenes/pipes/pipebend.tscn"),
#4x
	preload("res://scenes/pipes/pipestraight.tscn"),
	preload("res://scenes/pipes/pipestraight.tscn"), 
	preload("res://scenes/pipes/pipestraight.tscn"),
	preload("res://scenes/pipes/pipestraight.tscn"), 
#1x
#	preload("res://scenes/pipes/pipecross.tscn"),
#1x
#	preload("res://scenes/pipes/pipetshape.tscn")
	]
	
var pipe_ends = []
var active_pipes = []

func _ready() -> void:
	for x in range(grid_size.x):
		for y in range(grid_size.y):
			var instance = spawn_random_pipe(Vector2(x,y))
			instance.looped.connect(check_loop)
			active_pipes.append(instance)
			var children = instance.get_children()
			for child in children:
				if child is PipeEnd:
					pipe_ends.append(child)
					
func _draw() -> void:
	for x in range(grid_size.x):
		for y in range(grid_size.y):
			var cell_position = Vector2(x, y) * cell_size
			draw_rect(Rect2(cell_position, cell_size), Color(0.5, 0.5, 0.5, 1), false)

func check_loop():
	var loop = true
	for pipe_end in pipe_ends:
		if not pipe_end.has_overlapping_areas():
			loop = false
			print("no loop")
		if loop:
			print("Loop")
			pipe_end.queue_free()

func spawn_random_pipe(cell_position: Vector2):
	var random_scene: PackedScene = pipe_scenes[randi() % pipe_scenes.size()]
	var instance = random_scene.instantiate()
	instance.position = (cell_position * cell_size) + cell_size/2
	add_child(instance)
	return instance
