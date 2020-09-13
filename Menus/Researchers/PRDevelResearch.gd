extends HBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var science_cost

# Called when the node enters the scene tree for the first time.
func _ready():
	update_cost()

func update_cost():
	science_cost = pow(4,Logic.recruit_upgrades-1) * Logic.CONVERTER_BASE_MATERIAL # Cost doubles with each purchase

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Label.set_text("Current Modifier: +" + str((Logic.recruit_mod-1.00)*100.0) + "%\n" +
					"Science to upgrade: " + str(science_cost))

func _buy_Research():
	if Logic.science >= science_cost:
		Logic.science -= science_cost
		Logic.recruit_upgrades += 1
		Logic.recruit_mod += Logic.upgrade_boost
		update_cost()
