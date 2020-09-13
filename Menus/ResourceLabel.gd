extends Label

export (String) var ResourceVar
export (String) var ModVar
var assigned_drones
var mod

func _process(delta):
	assigned_drones = Logic.get(ResourceVar)
	mod = Logic.get(ModVar)
	set_text("Resources per second: " + str(assigned_drones * Logic.resources_per_drone_per_second * mod) + "  +(" + str(Logic.resources_per_drone_per_second * mod) + ")\n"
			+ "Drones Assigned: " + str(assigned_drones))
