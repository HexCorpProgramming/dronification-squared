extends TextureButton

export (Array, String) var text

onready var textbox = load("res://Objects/TextBox.tscn")

var rng = RandomNumberGenerator.new()

var lastresult = -1

func _ready():
	rng.seed = hash(Global.ID)

func _pressed():
	#Account for rapid clicking
	if $TextBoxHolder.get_child_count() != 0: 
		var n = $TextBoxHolder.get_child(0)
		$TextBoxHolder.remove_child(n)
		n.queue_free()
	var box = textbox.instance()
	box._set_position(Vector2(0,0))
	var index = get_random_index(text)
	box.get_node("Label").text = text[index]
	$TextBoxHolder.add_child(box)
	$TextBoxHolder.visible = true

func reset():
	# Textbox decay
	$TextBoxHolder.visible = false

func get_random_index(arr_text):
	var result = rng.randi_range(0,arr_text.size()) -1
	
	#Ensure new responses
	while result == lastresult:
		result = rng.randi_range(0,arr_text.size()) -1
	
	lastresult = result
	return result
