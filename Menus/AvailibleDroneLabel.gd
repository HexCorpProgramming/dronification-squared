extends Label

func _process(_delta):
	set_text("Available Drones: " + Logic.format_number_int(Logic.available_drones))
