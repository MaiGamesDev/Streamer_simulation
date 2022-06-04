extends Button

signal window_pressed

func _ready():
	emit_signal("window_pressed", rect_global_position)

func _on_Window_pressed():
	emit_signal("window_pressed", rect_global_position)
	
