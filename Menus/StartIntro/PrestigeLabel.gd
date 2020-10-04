extends Label

func _ready():
	if Logic.prestige_count > 0:
		visible = true
		text = "Prestige No. %d" % Logic.prestige_count
