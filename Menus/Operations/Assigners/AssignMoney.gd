extends HBoxContainer

func _process(_delta):
	var current_mps = Logic.assigned_drones_money * Logic.resources_per_drone_per_second * Logic.money_mod
	var addable_mps = Logic.resources_per_drone_per_second * Logic.money_mod
	$Label.set_text("Money per second: " + Logic.format_number(current_mps) + "  +(" + str(addable_mps) + ")\n"
			+ "Drones Assigned: " + Logic.format_number_int(Logic.assigned_drones_money))

func _assign(amount):
	if Logic.available_drones >= amount:
		Logic.assigned_drones_money += amount
		Logic.available_drones -= amount
