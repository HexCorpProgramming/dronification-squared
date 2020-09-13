extends Label

export (String) var LogicNumber

func _process(delta):
	set_text(str(Logic.get(LogicNumber)))
