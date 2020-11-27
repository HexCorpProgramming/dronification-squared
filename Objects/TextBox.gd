extends Control

func _ready():
	var index = $Label.text.find("%id") 
	if index != -1:
		$Label.text = $Label.text.replace("%id", Global.ID)


func _on_Disappear_timeout():
	get_parent().get_parent().reset()
	queue_free()

func _on_Char_timeout():
	$Label.visible_characters += 1
	if $Label.percent_visible == 1.00:
		$Disappear.start()
		
func _set_position(vec2):
	print("Setting position!")
