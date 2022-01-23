extends Control

export(String) var input_name:String        = ""
export(String) var input_description:String = ""
export(String) var input_value:String       = ""

func _ready()->void:
	$VBoxContainer/Label.text    = input_name
	$VBoxContainer/TextEdit.text = input_value

	self.set_tooltip(input_description)
