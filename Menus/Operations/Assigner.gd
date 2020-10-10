extends HBoxContainer

export (String, "Materials", "Money", "Science") var resource_name = "Materials"
export (String, "assigned_materials", "assigned_money", "assigned_science") var assign_var = "assigned_materials"
export (String, "materials_mod", "money_mod", "science_mod") var mod_var = "materials_mod"

onready var label = get_node("VBoxContainer/Label2")

onready var assign1 = get_node("GridContainer/Assign1")
onready var assign10 = get_node("GridContainer/Assign10")
onready var assign100 = get_node("GridContainer/Assign100")
onready var assign1K = get_node("GridContainer/Assign1K")



func _ready():
	update_text()
	#update_display()

func get_assign_var():
	return Logic.get(assign_var)
	
func set_assign_var(value):
	Logic.set(assign_var,value)

func get_mod_var():
	return Logic.get(mod_var)

func update_display():

	var current_sps = get_assign_var() * Logic.resources_per_drone_per_second * get_mod_var()
	var addable_sps = Logic.resources_per_drone_per_second * get_mod_var()
	label.set_text(resource_name + " per second: " + Logic.format_number(current_sps) + "  +(" + Logic.format_number(addable_sps) + ")\n"
			+ "Drones Assigned: " + Logic.format_number_int(get_assign_var()))

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


func swap_operations(operation):
	if operation == "+":
		assign1.text = assign1.text.replace("-","+")
		assign10.text = assign10.text.replace("-","+")
		assign100.text = assign100.text.replace("-","+")
		assign1K.text = assign1K.text.replace("-","+")
	else:
		assign1.text = assign1.text.replace("+","-")
		assign10.text = assign10.text.replace("+","-")
		assign100.text = assign100.text.replace("+","-")
		assign1K.text = assign1K.text.replace("+","-")

func _assign(amount):
	var real_amount = amount * Logic.multi * Global.assign_mod
	var assignmax = false
	
	# Can probably change this into one if statement, but i think it makes more sense like this 
	if Global.is_assigning: # We are adding drones to operations
		if Logic.available_drones < real_amount: #We dont have enough drones to assign what we want so we assign all
			assignmax = true
	else:
		if get_assign_var() < abs(real_amount):
			assignmax = true
			
	if not assignmax: # change the amount requested
		set_assign_var(get_assign_var() + real_amount)
		Logic.available_drones -= real_amount
	elif Global.is_assigning: # Not enough, add all that we can
		set_assign_var(get_assign_var() + Logic.available_drones)
		Logic.available_drones = 0
	else:
		Logic.available_drones += Logic.assigned_drones_science
		set_assign_var(0)
	update_display()
