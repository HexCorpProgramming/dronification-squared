extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (String) var LogicNumber


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	set_text(str(Logic.get(LogicNumber)))
