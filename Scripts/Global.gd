extends Node

var ID = "0000"

var is_assigning = true
var assign_mod = 1

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		OS.set_window_fullscreen(!OS.is_window_fullscreen())

func clear_data():
	Logic.reset_values()
	var dir = Directory.new()
	dir.open("user://")
	dir.remove("savefile.save")
	
