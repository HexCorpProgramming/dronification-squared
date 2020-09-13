extends Label

func _process(delta):
	set_text("Drones awaiting Assignment: " + Logic.format_number_int(Logic.available_drones))
