extends Area2D
class_name Pipe

@onready var empty: Sprite2D = $Empty
@onready var full: Sprite2D = $Full

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)
	print(Global.connected_pipes)
	
func _process(_delta: float) -> void:
	if has_overlapping_areas():
		fill_pipe()
		
	else:
		empty_pipe()
		
	
func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if empty.get_rect().has_point(to_local(event.position)):
			rotate_pipe()
			print("at input " + str(Global.connected_pipes))
		

func _on_area_entered(area: Area2D) -> void:
	Global.connected_pipes.append(self)
	if area.full.visible and area not in Global.connected_pipes:
			Global.connected_pipes.append(area)
			print("at area entered " + str(Global.connected_pipes))
			
func _on_area_exited(area: Area2D) -> void:
		if self in Global.connected_pipes:
			Global.connected_pipes.erase(self)
		if area in Global.connected_pipes:
			Global.connected_pipes.erase(area)
		print("at area exited " + str(Global.connected_pipes))
			
func rotate_pipe():
	rotation_degrees += 90

func fill_pipe():
		empty.hide()
		full.show()
		
func empty_pipe():
		empty.show()
		full.hide()
