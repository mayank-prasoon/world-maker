extends Control

export(String) var input_name:String            = ""
export(String) var input_description:String     = ""
export(int)    var input_value:int              = 0
export(Array)  var input_dropdown_option:Array  = [""]

func _ready():
	$VBoxContainer/Label.text = input_name

	for x in input_dropdown_option:
		$VBoxContainer/HBoxContainer/OptionButton.add_item(x)
	$VBoxContainer/HBoxContainer/OptionButton.selected = input_value

	self.set_tooltip(input_description)
