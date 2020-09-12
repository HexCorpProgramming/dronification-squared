extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (String) var ResourceVar
var assigned_drones

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	assigned_drones = Logic.get(ResourceVar)
	set_text("Resources per second: " + str(assigned_drones * Logic.resources_per_drone_per_second) + "  +(" + str(Logic.resources_per_drone_per_second) + ")\n"
			+ "Drones Assigned: " + str(assigned_drones))
