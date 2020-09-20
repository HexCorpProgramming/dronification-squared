extends Label

func tick():
	set_text(Logic.format_number_int(Logic.recruits_rounded))
