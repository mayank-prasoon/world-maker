extends Control

export(String) var input_name:String        = ""
export(String) var input_description:String = ""
export(String) var input_value:String       = ""

func _ready()->void:
	$VBoxContainer/Label.text                = input_name
	$VBoxContainer/LineEdit.text             = input_value
	$VBoxContainer/LineEdit.placeholder_text = input_description
	
	self.set_tooltip(input_description)
