extends CenterContainer

var show_cool = 0.1

func _on_Stream_talk_line_changed():
	$Label.visible_characters = 0
	show_text()
	
func show_text():
	for i in $Label.text.length():
		$Label.visible_characters = i
		yield(get_tree().create_timer(show_cool),"timeout")
