extends MarginContainer

export(String, FILE, "*.json") var stream_chat_lines_data 

onready var chatLog = get_node("VBoxContainer/RichTextLabel")
onready var inputLabel = get_node("VBoxContainer/HBoxContainer/Label")
onready var inputField = get_node("VBoxContainer/HBoxContainer/LineEdit")

var chat_line = ['null']
var chat_line_order = 0
var chat_cool = 2.0

var groups = [
	{'name': 'Player', 'color': '#00abc7'},
	{'name': 'Match', 'color': '#ffdd8b'},
	{'name': 'Global', 'color': '#ffffff'}
]
var group_index = 0
var user_name = 'Player'

func _ready():
	inputField.connect("text_entered", self,'text_entered')
	change_group(0)
	
	load_skill_data()
	event_chat()

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ENTER:
			inputField.grab_focus()
		if event.pressed and event.scancode == KEY_ESCAPE:
			inputField.release_focus()
		if event.pressed and event.scancode == KEY_TAB:
			change_group(1)


func load_skill_data():
	var file = File.new()
	if not file.file_exists(stream_chat_lines_data):
		print("ERROR : can't find stream_chat_lines_data")
		return
	file.open(stream_chat_lines_data, File.READ)
	chat_line = parse_json(file.get_as_text())
	file.close()
	

func change_group(value):
	group_index += value
	if group_index > (groups.size() - 1):
		group_index = 0
	inputLabel.text = '[' + groups[group_index]['name'] + ']'
	inputLabel.set("custom_colors/font_color", Color(groups[group_index]['color']))
	
func add_message(username, text, group = 0, color = ''):
	chatLog.bbcode_text += '\n' 
	if color == '':
		chatLog.bbcode_text += '[color=' + groups[group]['color'] + ']'
	else:
		chatLog.bbcode_text += '[color=' + color + ']'
	if username != '':
		chatLog.bbcode_text += '[' + username + ']: '
	chatLog.bbcode_text += text
	chatLog.bbcode_text += '[/color]'

func text_entered(text):
	if text =='/h':
		add_message('', 'There is no help message yet!', 0, '#ff5757')
		inputField.text = ''		
		return
	if text != '':
		add_message(user_name, text, group_index)
		# Here you have to send the message to the server
		print(text)
		inputField.text = ''


func event_chat():
	add_message('jungbung',chat_line[chat_line_order],0,'#ff5757')
	
	yield(get_tree().create_timer(chat_cool), "timeout")
	
	chat_line_order += 1
	if chat_line_order > chat_line.size() -1:
		chat_line_order = 0
	event_chat()
