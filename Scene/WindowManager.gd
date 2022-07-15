extends Control

signal move_to_top

var tween_time = 0.2

var current_rect_size = Vector2(0,0)
var current_rect_global_position = Vector2(0,0)
var is_window_closed = false

var window_button_position = Vector2(0,0)

var drag_position = null
var rect_size_origin = null
var rect_global_position_origin = null

func _ready():
	current_rect_size = rect_size
	move_innerwindow()

func move_innerwindow():
	move_child($InnerWindow, 0)

func close():
	
	$Tween.interpolate_property(self, "rect_size", rect_size, Vector2(0,0), tween_time, $Tween.TRANS_LINEAR,Tween.EASE_IN)
	$Tween.start()
	
	$Tween.interpolate_property(self, "modulate", modulate, Color(1, 1, 1, 0), tween_time, $Tween.TRANS_LINEAR,Tween.EASE_IN)
	$Tween.start()
	
	$Tween.interpolate_property(self, "rect_global_position", rect_global_position, window_button_position, tween_time, $Tween.TRANS_LINEAR,Tween.EASE_IN)
	$Tween.start()
	
	current_rect_size = rect_size
	current_rect_global_position = rect_global_position

func open():
	
	show()
	
	$Tween.interpolate_property(self, "rect_size", rect_size, current_rect_size, tween_time, $Tween.TRANS_LINEAR,Tween.EASE_IN)
	$Tween.start()
	
	$Tween.interpolate_property(self, "modulate", modulate, Color(1, 1, 1, 1), tween_time, $Tween.TRANS_LINEAR,Tween.EASE_IN)
	$Tween.start()
	
	$Tween.interpolate_property(self, "rect_global_position", rect_global_position, current_rect_global_position, tween_time, $Tween.TRANS_LINEAR,Tween.EASE_IN)
	$Tween.start()


func _on_Minimize_pressed():
	if is_window_closed == false:
		close()
	if is_window_closed == true:
		open()

func _on_Close_pressed():
	hide()

func _on_Window_window_pressed(position):
	window_button_position = position
	_on_Minimize_pressed()

#창 위치조정
func _on_TopControl_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			drag_position = get_global_mouse_position() - rect_global_position
		else:
			drag_position = null
	if event is InputEventMouseMotion and drag_position:
		rect_global_position = get_global_mouse_position() - drag_position

#오른쪽으로 늘리기
func _on_RightControl_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			drag_position = get_global_mouse_position() - rect_global_position
			rect_size_origin = rect_size
		else:
			drag_position = null
			rect_size_origin = null
			
	if event is InputEventMouseMotion and drag_position:
		rect_size.x = (rect_size_origin + get_global_mouse_position() - rect_global_position - drag_position).x

#아래로 늘리기
func _on_BottomControl_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			drag_position = get_global_mouse_position() - rect_global_position
			rect_size_origin = rect_size
		else:
			drag_position = null
			rect_size_origin = null
			
	if event is InputEventMouseMotion and drag_position:
		rect_size.y = (rect_size_origin + get_global_mouse_position() - rect_global_position - drag_position).y

#왼쪽으로 늘리기
func _on_LeftControl_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			drag_position = get_global_mouse_position() - rect_global_position
			rect_size_origin = rect_size
			rect_global_position_origin = rect_global_position
		else:
			drag_position = null
			rect_size_origin = null
			
	if event is InputEventMouseMotion and drag_position:
		if rect_size.x > rect_min_size.x + 1:
			rect_global_position.x = (get_global_mouse_position() - drag_position).x
		rect_size.x = (rect_size_origin - (get_global_mouse_position() - rect_global_position_origin - drag_position)).x

#창 앞으로
func _on_FullControl_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		print("a")
		emit_signal("move_to_top", self)

func _on_Tween_tween_all_completed():
	is_window_closed = !is_window_closed
	if is_window_closed:
		hide()


func _on_IconGagle_pressed():
	show()
	if is_window_closed == true:
		open()


