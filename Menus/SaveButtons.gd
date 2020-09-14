extends Panel


func save_game():
	var save_file = File.new()
	save_file.open("user://savefile.save", File.WRITE)
	var save_data = Logic.create_dict()
	save_file.store_line(to_json(save_data))
	save_file.close()
	
func load_game():
	var save_file = File.new()
	save_file.open("user://savefile.save", File.READ)
	var save_data = parse_json(save_file.get_line())
	Logic.parse_dict(save_data)
	save_file.close()