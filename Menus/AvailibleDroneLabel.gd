extends Label


func _process(delta):
	set_text("Drones waiting Assignment: " + str(Logic.available_drones))
