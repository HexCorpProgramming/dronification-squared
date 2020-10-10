extends CenterContainer

export (String) var Text
export (String) var Description

export (int) var cost
export (int) var max_buyable

export (int) var research_code


func _ready():
	$Label.text = Text

func _on_Button_mouse_entered():
	update_description_text()
							


func _on_Button_pressed():
	if Logic.science >= cost and Global.r.researches_bought[research_code] < max_buyable:
		Logic.science -= cost
		Global.r.researches_bought[research_code] += 1
		update_description_text()
		Logic.update_display_next_tick = true

		
func update_description_text():
	get_tree().call_group("research text", "set_text", str(research_code) + ": "
							+ Description + " " + str(Global.r.researches_bought[research_code]) 
							+ "/" + str(max_buyable) + "\nCost: " + Logic.format_number_int(cost)
							+ " Science") 
