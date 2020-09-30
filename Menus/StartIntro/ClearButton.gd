extends TextureButton

var askconfirm = false

func _hide():
	askconfirm = false
	$Label.visible = true
	$Label2.visible = false
	
func _pressed():
	if not askconfirm:
		askconfirm = true
		$Label.visible = false
		$Label2.visible = true
	else:
		Global.clear_data()
		get_parent()._ready()
		_hide()
