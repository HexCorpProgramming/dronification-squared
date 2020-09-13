extends Label

func _process(delta):
	set_text("Drones awaiting Assignment: " + str(Logic.available_drones))
