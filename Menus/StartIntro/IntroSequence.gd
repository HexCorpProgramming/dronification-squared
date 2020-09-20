extends Label

var text_count = 0
var input
var ID

func _advance():
	text_count+=1
	match text_count:
		0:
			text = "Hello Applicant."
		1:
			text = "Thank you for applying to join this HexCorp Dronification Facility"
		2:
			text = "You have been selected to be the Hive Mxtress’ secretary.\nYour role will consist of administering this facility for the benefit of HexCorp.\nDo you accept?"
			$Yes1.visible = true
			$Yes2.visible = true
			$Obey.visible = false
		3:
			text = "Good drone."
			$Yes1.visible = false
			$Yes2.visible = false
			$Obey.visible = true
		4: 
			text = "Please input your name or 4 digit ID:"
			$LineEdit.visible = true
			$Obey/Label.text = "Submit"
		5:
			input = $LineEdit.text
			ID = clean_id(input)
			text = "Thank you, #%s, name accepted." % ID
			$LineEdit.visible = false
			$Obey/Label.text = "Continue"
		6:
			text = "Secretary #%s, your task is to focus on the management of this facility.\nYou will gather recruits.\nYou will dronify them.\nYou will obtain resources.\nYou will increase production." % ID
		7:
			text = "Commence task now."
			$Obey/Label.text = "Obey"
		8:
			get_parent()._on_menu()
			ID = String(ID)
			Global.ID = ID
			# Reset
			text_count = 0
			text = "Hello Applicant."
			$LineEdit.text = ID

func clean_id(id):
	if id.is_valid_integer(): #or id.is_valid_hex_number(): #if numbers or valid hex is put in, accept it
		return id.substr(0,4).pad_zeros(4)
	else: #Else, see if we cant squeeze out a number from the input?
		var testid = int(id)
		if testid == 0: # if no dice, time to generate
			return generate_id(hash(id))
		else:
			return testid

func generate_id(rngseed):
	var rng = RandomNumberGenerator.new()
	rng.seed = rngseed
	var id = rng.randi_range(0,9999)
	return String(id).pad_zeros(4)
	
