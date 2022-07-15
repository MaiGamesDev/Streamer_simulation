extends MarginContainer

signal talk_line_changed

export(String, FILE, "*.json") var stream_talk_lines_data 

export(AnimatedTexture) var idle_texture
export(AnimatedTexture) var angry_texture
export(AnimatedTexture) var business_texture
export(AnimatedTexture) var cat_texture
export(AnimatedTexture) var crazy_texture
export(AnimatedTexture) var crazy2_texture
export(AnimatedTexture) var crazy3_texture
export(AnimatedTexture) var cry_texture
export(AnimatedTexture) var hello_texture
export(AnimatedTexture) var pointing_texture
export(AnimatedTexture) var pose_texture
export(AnimatedTexture) var sexy_texture

onready var background = get_node("VBox/Subtitle/Background")
onready var label = get_node("VBox/Subtitle/Label")

var talk_line = ['']
var talk_line_order = 0
var talk_cool = 5.0
var passAddLine = true

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
	passAddLine = true
	emote(talk_line[talk_line_order])
	
	if passAddLine == false:
		add_line(talk_line[talk_line_order])
		yield(get_tree().create_timer(talk_cool), "timeout")
	
	talk_line_order += 1
	if talk_line_order > talk_line.size() -1:
		talk_line_order = 0
	event_talk()
	
func add_line(text):
	label.text = text
	emit_signal("talk_line_changed")

func emote(text):
	match text:
		"/idle":
			set_texture(idle_texture)
		"/angry":
			set_texture(angry_texture)
		"/business":
			set_texture(business_texture)
		"/cat":
			set_texture(cat_texture)
		"/crazy":
			set_texture(crazy_texture)
		"/crazy2":
			set_texture(crazy2_texture)
		"/crazy3":
			set_texture(crazy3_texture)
		"/cry":
			set_texture(cry_texture)
		"/hello":
			set_texture(hello_texture)
		"/pointing":
			set_texture(pointing_texture)
		"/pose":
			set_texture(pose_texture)
		"/sexy":
			set_texture(sexy_texture)
		_:
			passAddLine = false

func set_texture(texture):
	$Sprite.texture = texture
	$Sprite.texture.current_frame = 0
