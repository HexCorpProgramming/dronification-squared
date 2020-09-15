extends Label

func _process(_delta):
	set_text("Drones Awaiting Assignment: " + Logic.format_number_int(Logic.available_drones))
