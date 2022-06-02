extends MarginContainer


var current_rect_size = Vector2(0,0)
var is_window_closed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	current_rect_size = rect_size

func close():
	$Tween.interpolate_property(self, "rect_size", rect_size, Vector2(0,0), 0.1, $Tween.TRANS_LINEAR,Tween.EASE_IN)
	$Tween.start()
	current_rect_size = rect_size
	is_window_closed = true

func open():
	$Tween.interpolate_property(self, "rect_size", rect_size, current_rect_size, 0.1, $Tween.TRANS_LINEAR,Tween.EASE_IN)
	$Tween.start()


func _on_Minimize_pressed():
	if is_window_closed == false:
		close()
	else:
		open()

func _on_Close_pressed():
	queue_free()
