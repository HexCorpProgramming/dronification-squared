extends Button

export (int) var AssignAmt
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _assign():
	if Logic.available_drones >= AssignAmt:
		Logic.assigned_drones_science += AssignAmt
		Logic.available_drones -= AssignAmt
