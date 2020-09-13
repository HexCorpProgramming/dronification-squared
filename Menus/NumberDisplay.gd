extends Label

export (String) var LogicNumber

func _process(delta):
	var number = Logic.get(LogicNumber)
	set_text(Logic.format_number(number))
