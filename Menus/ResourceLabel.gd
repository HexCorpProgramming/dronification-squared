extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (String) var ResourceVar
export (String) var ModVar
var assigned_drones
var mod


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	assigned_drones = Logic.get(ResourceVar)
	mod = Logic.get(ModVar)
	set_text("Resources per second: " + str(assigned_drones * Logic.resources_per_drone_per_second * mod) + "  +(" + str(Logic.resources_per_drone_per_second * mod) + ")\n"
			+ "Drones Assigned: " + str(assigned_drones))
