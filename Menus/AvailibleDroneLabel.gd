extends Label

func _process(_delta):
	set_text("Drones awaiting Assignment: " + Logic.format_number_int(Logic.available_drones))
