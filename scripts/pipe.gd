extends Node2D

@onready var empty: Sprite2D = $Empty
@onready var full: Sprite2D = $Full

var pipe_ends := [PipeEnd]

func _ready() -> void:
	pipe_ends = get_pipe_ends()
	for pipe in pipe_ends:
		pipe.fill.connect(check_pipes)
		pipe.empty.connect(check_pipes)

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if empty.get_rect().has_point(to_local(event.position)):
			rotate_pipe()

func rotate_pipe():
	rotation_degrees += 90
	check_pipes()
	print(Global.connected_pipes)
	
func check_pipes():
	var overlapping = false
	for pipe_end in pipe_ends:
		if pipe_end.has_overlapping_areas():
			overlapping = true
			break

	if overlapping:
		empty.hide()
		full.show()
	else:
		empty.show()
		full.hide()

func get_pipe_ends():
	var result = []
	for child in get_children():
		if child is PipeEnd:
			result.append(child)
	return result

func check_loop():
	var loop = true
	for pipe_end in pipe_ends:
		if not pipe_end.has_overlapping_areas():
			loop = false
			break
	if loop:
		queue_free()
