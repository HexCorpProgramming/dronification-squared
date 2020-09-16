extends Label

func _process(_delta):
	set_text("Drones Available: \n" + Logic.format_number_int(Logic.available_drones))
