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
	
func _on_intro():
	visible = false
	get_node("/root/Root/Intro").visible = true
	
func _on_menu():
	visible = false
	get_node("/root/Root/MainMenu").visible = true
	get_node("/root/Root/Header").visible = true

func _on_credits():
	visible = false
	get_node("/root/Root/Credits").visible = true
	
func _on_start():
	visible = false
	get_node("/root/Root/Header").visible = false
	get_node("/root/Root/Start").visible = true
	get_node("/root/Root/Start/MainMenuElements")._ready()

func _on_back():
	visible = false
	get_node("/root/Root/MainMenu").visible = true

