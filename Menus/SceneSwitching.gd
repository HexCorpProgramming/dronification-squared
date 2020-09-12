extends Control


func _on_recruitment():
	visible = false
	get_node("/root/Root/Recruitment").visible = true

func _on_conversion():
	visible = false
	get_node("/root/Root/Conversion").visible = true
	
func _on_operations():
	visible = false
	get_node("/root/Root/Operations").visible = true
	
func _on_research():
	visible = false
	get_node("/root/Root/Research").visible = true
