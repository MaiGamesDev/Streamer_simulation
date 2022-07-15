extends Node

func _input(event):
	if event is InputEventKey:
		if Input.is_action_just_pressed("ui_accept"):
			get_tree().reload_current_scene()
