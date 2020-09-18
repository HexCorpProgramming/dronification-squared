extends Control

onready var saveload = load("res://Menus/SaveButtons.gd").new()

func _ready():
	var success = saveload.load_game()
	if success: #save file found
		$StartButton.visible = false
		$StartButton.disabled = true
		$ContinueButton.visible = true
		$ContinueButton.disabled = false
