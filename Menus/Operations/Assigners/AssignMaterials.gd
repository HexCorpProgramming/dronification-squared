extends HBoxContainer

onready var label = get_node("VBoxContainer/Label2")

onready var assign1 = get_node("GridContainer/AssignMaterials")
onready var assign10 = get_node("GridContainer/AssignMaterials2")
onready var assign100 = get_node("GridContainer/AssignMaterials3")
onready var assign1K = get_node("GridContainer/AssignMaterials4")

func _ready():
	update_text()

func _process(_delta):
	update_text()
	var current_sps = Logic.assigned_drones_materials * Logic.resources_per_drone_per_second * Logic.science_mod
	var addable_sps = Logic.resources_per_drone_per_second * Logic.money_mod
	label.set_text("Money per second: " + Logic.format_number(current_sps) + "  +(" + str(addable_sps) + ")\n"
			+ "Drones Assigned: " + Logic.format_number_int(Logic.assigned_drones_materials))

func _assign(amount):
	if Logic.available_drones >= amount * Logic.multi:
		Logic.assigned_drones_materials += amount * Logic.multi
		Logic.available_drones -= amount * Logic.multi

func update_text():
	if Logic.multi == 1: #5 chars per button
		assign1.set_text("  +1 ")
		assign10.set_text(" +10 ")
		assign100.set_text("+100 ")
		assign1K.set_text("+1K ")
	elif Logic.multi == 1000: #K
		assign1.set_text(" +1K ")
		assign10.set_text("+10K ")
		assign100.set_text("+100K")
		assign1K.set_text("+1M ")
	elif Logic.multi == 1000000: #M
		assign1.set_text(" +1M ")
		assign10.set_text("+10M ")
		assign100.set_text("+100M")
		assign1K.set_text("+1B ")
