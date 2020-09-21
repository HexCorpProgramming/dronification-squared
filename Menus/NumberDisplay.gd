extends Label

export (String) var LogicNumber

func tick():
	var number = Logic.get(LogicNumber)
	set_text(Logic.format_number(number))
