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
	$Label.set_text("Recruits per second: " + str(Logic.auto_recruiters * Logic.recruits_per_second* Logic.recruit_mod) + " (+" + str(Logic.recruits_per_second*Logic.recruit_mod) + ") \n" +
					"Auto-recruiters: " + str(Logic.auto_recruiters) +" (+1)\n" +
					"Cost: " + str(money_cost) + " money " + str(material_cost) +" materials")

func _buy_Recruiter():
	if Logic.materials >= material_cost and Logic.money >= money_cost:
		Logic.materials -= material_cost
		Logic.money -= money_cost
		Logic.auto_recruiters += 1
		update_cost()
