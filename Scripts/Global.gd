extends Node

var ID = "0000"

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		OS.set_window_fullscreen(!OS.is_window_fullscreen())
