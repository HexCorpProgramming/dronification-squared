extends HBoxContainer

var material_cost
var money_cost

func _ready():
	update_cost()

func update_cost():
	material_cost = pow(2,Logic.auto_recruiters) * Logic.RECRUITER_BASE_MATERIAL # Cost doubles with each purchase
	money_cost = pow(2,Logic.auto_recruiters) * Logic.RECRUITER_BASE_MONEY

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var current_rps = Logic.auto_recruiters * Logic.recruits_per_second* Logic.recruit_mod
	var addable_rps = Logic.recruits_per_second*Logic.recruit_mod
	$Label.set_text("Recruits per second: " + Logic.format_number(current_rps) + " (+" + str(addable_rps) + ") \n" +
					"Auto-recruiters: " + str(Logic.auto_recruiters) +" (+1)\n" +
					"Cost: " + Logic.format_number(money_cost) + " money " + Logic.format_number(material_cost) +" materials")

func _buy_Recruiter():
	if Logic.materials >= material_cost and Logic.money >= money_cost:
		Logic.materials -= material_cost
		Logic.money -= money_cost
		Logic.auto_recruiters += 1
		update_cost()
