extends HBoxContainer

func _process(delta):
	var current_mps = Logic.assigned_drones_materials * Logic.resources_per_drone_per_second * Logic.materials_mod
	var addable_mps = Logic.resources_per_drone_per_second * Logic.materials_mod
	$Label.set_text("Materials per second: " + str(current_mps) + "  +(" + str(addable_mps) + ")\n"
			+ "Drones Assigned: " + str(Logic.assigned_drones_materials))

func _assign(amount):
	if Logic.available_drones >= amount:
		Logic.assigned_drones_materials += amount
		Logic.available_drones -= amount
