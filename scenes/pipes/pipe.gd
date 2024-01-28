extends Area2D

@onready var empty: Sprite2D = $Empty
@onready var full: Sprite2D = $Full
@onready var connected_pipes = []

func _ready() -> void:
	add_to_group("pipes")
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)
	
func _process(delta: float) -> void:
	if has_overlapping_areas():
		fill_pipe()
	else:
		empty_pipe()
	
func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if empty.get_rect().has_point(to_local(event.position)):
			rotate_pipe()
			print(connected_pipes)

func rotate_pipe():
	self.rotation += 1.5708

func _on_area_entered(area: Area2D) -> void:
	if area in get_tree().get_nodes_in_group("pipes"):
		var adjacent_pipes = get_overlapping_areas()
		if adjacent_pipes not in connected_pipes:
			connected_pipes.append(adjacent_pipes)
		if area not in connected_pipes:	
			connected_pipes.append(area)

func _on_area_exited(area: Area2D) -> void:
		if area in connected_pipes:
			connected_pipes.erase(area)

func fill_pipe():
		empty.hide()
		full.show()
#
func empty_pipe():
		empty.show()
		full.hide()
