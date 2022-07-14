extends MarginContainer

export(String, FILE, "*.json") var stream_talk_lines_data 

onready var background = get_node("VBox/Subtitle/Background")
onready var label = get_node("VBox/Subtitle/Label")

var talk_line = ['안','녕']
var talk_line_order = 0
var talk_cool = 3.0

var extra_size = Vector2(20,10)

func _ready():
	load_skill_data()
	
	event_talk()

func _process(delta):
	set_background()


func load_skill_data():
	var file = File.new()
	if not file.file_exists(stream_talk_lines_data):
		print("ERROR : can't find stream_talk_lines_data")
		return
	file.open(stream_talk_lines_data, File.READ)
	talk_line = parse_json(file.get_as_text())
	file.close()
	

func set_background():
	background.rect_size = label.rect_size + extra_size
	background.rect_position = label.rect_position - extra_size/2

func event_talk():
	add_line(talk_line[talk_line_order])
	
	yield(get_tree().create_timer(talk_cool), "timeout")
	
	talk_line_order += 1
	if talk_line_order > talk_line.size() -1:
		talk_line_order = 0
	event_talk()
	
func add_line(text):
	label.text = text

