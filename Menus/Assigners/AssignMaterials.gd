extends Button

export (int) var AssignAmt

func _assign():
	if Logic.available_drones >= AssignAmt:
		Logic.assigned_drones_materials += AssignAmt
		Logic.available_drones -= AssignAmt
