extends HBoxContainer

var science_cost

func _ready():
	update_cost()

func update_cost():
	science_cost = pow(4,Logic.materials_upgrades) * Logic.RESEARCH_BASE_SCIENCE # Cost quadruples with each purchase

func _process(delta):
	$Label.set_text("Current Modifier: +" + str((Logic.materials_mod-1.00)*100.0) + "%\n" +
					"Science to upgrade: " + str(science_cost))

func _buy_Research():
	if Logic.science >= science_cost:
		Logic.science -= science_cost
		Logic.materials_upgrades += 1
		Logic.materials_mod = (pow(2, Logic.materials_upgrades-1) * Logic.upgrade_boost)+1.00
		update_cost()

