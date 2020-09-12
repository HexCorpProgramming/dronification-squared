extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.

func _process(delta):
	set_text("Drones waiting Assignment: " + str(Logic.available_drones))
