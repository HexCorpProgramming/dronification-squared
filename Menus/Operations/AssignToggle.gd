extends Button

func _ready():
	text = "   Assign Drones   " #Button uses larger string in editor to help with proper placement

func _pressed():
	Global.is_assigning = !Global.is_assigning
	var operation
	if Global.is_assigning:
		text = "Assign Drones"
		operation = "+"
		Global.assign_mod = 1
	else:
		text = "Deassign Drones"
		operation = "-"
		Global.assign_mod = -1
	get_tree().call_group("operations","swap_operations", operation)
