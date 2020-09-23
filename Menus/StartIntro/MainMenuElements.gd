extends Control

onready var saveload = load("res://Menus/SaveButtons.gd").new()

func _ready():
	update_buttons()

func _visibility_changed():
	update_buttons()

func update_buttons():
	var success = saveload.load_game()
	if success: #save file found
		$StartButton.visible = false
		$StartButton.disabled = true
		$ContinueButton.visible = true
		$ContinueButton.disabled = false
		$IntroButton.visible = true
		$IntroButton.disabled = false
		$ClearButton.visible = true
		$ClearButton.disabled = false
	else: #no save file
		$StartButton.visible = true
		$StartButton.disabled = false
		$ContinueButton.visible = false
		$ContinueButton.disabled = true
		$IntroButton.visible = false
		$IntroButton.disabled = true
		$ClearButton.visible = false
		$ClearButton.disabled = true
