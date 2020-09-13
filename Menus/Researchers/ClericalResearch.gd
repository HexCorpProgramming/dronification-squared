extends HBoxContainer

var science_cost

func _ready():
	update_cost()

func update_cost():
	science_cost = pow(4,Logic.money_upgrades-1) * Logic.CONVERTER_BASE_MATERIAL # Cost quadruples with each purchase

func _process(delta):
	$Label.set_text("Current Modifier: +" + str((Logic.money_mod-1.00)*100.0) + "%\n" +
					"Science to upgrade: " + str(science_cost))

func _buy_Research():
	if Logic.science >= science_cost:
		Logic.science -= science_cost
		Logic.money_upgrades += 1
		Logic.money_mod += Logic.upgrade_boost
		update_cost()
