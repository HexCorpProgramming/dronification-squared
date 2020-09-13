extends Label

func _process(delta):
	set_text(Logic.format_number_int(Logic.recruits_rounded))
