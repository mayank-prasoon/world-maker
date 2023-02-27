extends RootFieldInput

# export var input_value: Array:Array            = [false]
@export var input_check_box_option: Array:Array = [""]

# === node ===
@onready var checkbox_container = $VBoxContainer/HBoxContainer

func _ready():
	$VBoxContainer/Label.text = input_name

	for check_box_name in input_check_box_option:
		var check_box:CheckBox          = CheckBox.new()
		check_box.size_flags_horizontal = SIZE_EXPAND
		check_box.text                  = check_box_name
		check_box.flat                  = true

		$VBoxContainer/HBoxContainer.add_child(check_box)

	var index = 0
	for state in input_value:
		var button:CheckBox = checkbox_container.get_children()[index]
		button.button_pressed      = state
		index += 1 # increase the index

	# connect the signals
	connect_signal_check_box()

# connect the signals
func connect_signal_check_box()->void:
	for x in checkbox_container.get_children():
		var node:CheckBox = x
		node.connect("toggled",Callable(self,"input_value_change"))

# emmit signal
func input_value_change(_state)->void:
	emit_signal("input_value_changed")

func dispaly()->String:
	var text_collection:Array = []
	var value:String          = ""
	
	for node in checkbox_container.get_children():
		if node.button_pressed == true:
			text_collection.append(node.text)
			text_collection.append(', ')
	
	if !(text_collection.size() == 0):
		text_collection.pop_back()
		if text_collection.size() >= 3:
			text_collection[-2] = " and "

		for x in text_collection:
			value += x
	else:
		value = input_null_display_value

	return input_display.format({'value' : value})
