extends Node2D

@onready var empty: Sprite2D = $Empty
@onready var full: Sprite2D = $Full

func _ready() -> void:
	for child in get_children():
		if child.has_signal("connected"):
			child.connected.connect(link_pipes)
	
	for child in get_children():
		if child.has_signal("disconnected"):
			child.disconnected.connect(unlink_pipes)

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if empty.get_rect().has_point(to_local(event.position)):
			print("A click!")
			rotate_pipe()

func link_pipes():
	empty.hide()
	full.show()
	
func unlink_pipes():
	empty.show()
	full.hide()

func rotate_pipe():
	self.rotation += 1.5708
