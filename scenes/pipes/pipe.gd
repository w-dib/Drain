extends Area2D

@onready var empty: Sprite2D = $Empty
@onready var full: Sprite2D = $Full

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func _process(delta: float) -> void:
	if has_overlapping_areas():
		empty.hide()
		full.show()
	
func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if empty.get_rect().has_point(to_local(event.position)):
			rotate_pipe()

func link_pipes():
		empty.hide()
		full.show()
	
func unlink_pipes():
		empty.show()
		full.hide()

func rotate_pipe():
	self.rotation += 1.5708

func _on_area_entered(area: Area2D) -> void:
		link_pipes()

func _on_area_exited(area: Area2D) -> void:
		unlink_pipes()

