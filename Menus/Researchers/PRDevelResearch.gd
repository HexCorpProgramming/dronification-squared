extends HBoxContainer

var science_cost

func _process(_delta):
	science_cost = pow(4,Logic.recruit_upgrades) * Logic.RESEARCH_BASE_SCIENCE # Cost quadruples with each purchase
	$Label.set_text("Current Modifier: +" + Logic.format_number_int((Logic.recruit_mod-1.00)*100.0) + "%\n" +
					"Science to upgrade: " + Logic.format_number(science_cost))

func _buy_Research():
	if Logic.science >= science_cost:
		Logic.science -= science_cost
		Logic.recruit_upgrades += 1
		Logic.recruit_mod = (pow(2, Logic.recruit_upgrades-1) * Logic.upgrade_boost)+1.00
