extends HBoxContainer

func _process(delta):
	var current_sps = Logic.assigned_drones_science * Logic.resources_per_drone_per_second * Logic.science_mod
	var addable_sps = Logic.resources_per_drone_per_second * Logic.science_mod
	$Label.set_text("Science per second: " + Logic.format_number(current_sps) + "  +(" + str(addable_sps) + ")\n"
			+ "Drones Assigned: " + Logic.format_number_int(Logic.assigned_drones_science))

func _assign(amount):
	if Logic.available_drones >= amount:
		Logic.assigned_drones_science += amount
		Logic.available_drones -= amount
