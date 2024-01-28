class_name Connector
extends Area2D

signal connected
signal disconnected

func _ready():
	area_entered.connect(_on_connector_entered)
	area_exited.connect(_on_connector_exited)
	
func _on_connector_entered(_body):
	connected.emit()
	
func _on_connector_exited(_body):
	disconnected.emit()
