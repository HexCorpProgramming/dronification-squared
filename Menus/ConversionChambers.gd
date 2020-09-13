extends HBoxContainer

var material_cost
var money_cost

func _ready():
	update_cost()

func update_cost():
	material_cost = pow(2,Logic.conversion_chambers-1) * Logic.CONVERTER_BASE_MATERIAL # Cost doubles with each purchase
	money_cost = pow(2,(Logic.conversion_chambers-1)) * Logic.CONVERTER_BASE_MONEY # -1 to account for the free one

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var current_dps = Logic.conversion_chambers * Logic.conversions_per_second* Logic.convert_mod
	var addable_dps = Logic.conversions_per_second*Logic.convert_mod
	$Label.set_text("Drones per second: " + str(current_dps) + " (+" + str(addable_dps) + ") \n" +
					"Auto-recruiters: " + str(Logic.conversion_chambers) +" (+1)\n" +
					"Cost: " + str(money_cost) + " money " + str(material_cost) +" materials")

func _buy_Chamber():
	if Logic.materials >= material_cost and Logic.money >= money_cost:
		Logic.materials -= material_cost
		Logic.money -= money_cost
		Logic.conversion_chambers += 1
		update_cost()
