extends Label

func tick():
	set_text("Drones Available: \n" + Logic.format_number_int(Logic.available_drones))
