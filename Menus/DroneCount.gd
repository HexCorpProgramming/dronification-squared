extends Label

func _process(_delta):
	var output = str(Logic.drones_rounded)
	for i in range(output.length()-3,0,-3): #from end of string to beginning
		output = output.insert(i,",")
	set_text(output)
