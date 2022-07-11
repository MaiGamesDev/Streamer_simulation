extends MarginContainer

onready var background = get_node("VBox/Subtitle/Background")
onready var label = get_node("VBox/Subtitle/Label")

var talk_line_order = 0

var talk_cool = 3.0

var extra_size = Vector2(20,10)

func _ready():
	event_talk()

func _process(delta):
	set_background()

func set_background():
	background.rect_size = label.rect_size + extra_size
	background.rect_position = label.rect_position - extra_size/2

func event_talk():
	var talk_line = ['중붕이...','우....웅우...','우래!!!!!']
	add_line(talk_line[talk_line_order])
	
	yield(get_tree().create_timer(talk_cool), "timeout")
	
	talk_line_order += 1
	if talk_line_order > talk_line.size() -1:
		talk_line_order = 0
	event_talk()
	
func add_line(text):
	label.text = text
