extends Node2D

func _ready() -> void:
	pipe_filled.connect(add_pipe)
	pipe_emptied.connect(remove_pipe)

func add_pipe():
	pass
	
func remove_pipe():
	pass


func _on_pipe_bend_pipe_emptied() -> void:
	pass # Replace with function body.
