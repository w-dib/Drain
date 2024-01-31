extends Area2D
class_name PipeEnd

@onready var full: Sprite2D = $"../Full"

signal fill
signal empty

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)
		
func _on_area_entered(area: Area2D) -> void:
	Global.connected_pipes.append(self)
	if full.visible and area not in Global.connected_pipes:
			Global.connected_pipes.append(area)
	fill.emit()
	
func _on_area_exited(area: Area2D) -> void:
	if self in Global.connected_pipes:
		Global.connected_pipes.erase(self)
	if area in Global.connected_pipes:
		Global.connected_pipes.erase(area)
	if not overlaps_area(area):
		empty.emit()
