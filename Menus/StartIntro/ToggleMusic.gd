extends TextureButton


func _pressed():
	var music = get_node("/root/Audio")
	music.set_stream_paused(!music.get_stream_paused())
