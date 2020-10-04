extends Label

onready var saveload = load("res://Menus/SaveButtons.gd").new()

var text_count = 0

func _advance():
	text_count+=1
	match text_count:
		0:
			text = "What excellent work you've done Secretary #%s." % Global.ID
		1:
			text = "Producing 7 billion drones is no small task."
		2:
			text = "Good drone."
		3:
			text = "Your task here is done, but if you choose to continue serving me here in this way, you may continue."
		4:
			text = "Your progress in the simulation will be reset, but you will gain a 1% boost to your normal drone production."
		5:
			text = "You've already reached 7 billion drones %d times, want to go again?" % (Logic.prestige_count + 1)
			$Obey.visible = false
			$Yes.visible = true
			$No.visible = true
		6: #Only occurs one saying no and pressing continue again
			text = ""
			$Obey.visible = false
			$CreditsText.visible = true
			prestige()
func _yes():
	prestige()
	get_tree().reload_current_scene()
	
func _no():
	text = "Rest well Secretary #%s, thank you for playing" % Global.ID
	$Yes.visible = false
	$No.visible = false
	$Obey.visible = true

func prestige():
	var store_count = Logic.prestige_count
	var store_mod = Logic.prestige_mod
	Logic.reset_values()
	Logic.prestige_count = store_count + 1
	Logic.prestige_mod = store_mod + 0.01
	saveload.save_game()
	saveload.load_game()
	

