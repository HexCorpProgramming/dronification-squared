extends HBoxContainer


func save_game():
	var save_file = File.new()
	save_file.open("user://savefile.save", File.WRITE)
	var save_data = Logic.create_dict()
	save_file.store_line(to_json(save_data))
	save_file.close()
	
func load_game():
	var success;
	var save_file = File.new()
	save_file.open("user://savefile.save", File.READ)
	var save_data = parse_json(save_file.get_line())
	if save_data != null:
		Logic.parse_dict(save_data)
		success = true
	else:
		success = false
	save_file.close()
	return success
