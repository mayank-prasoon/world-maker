class_name RootFieldInput
extends Control

signal input_value_changed


export(String) var input_name:String            = ""
export(String) var input_description:String     = ""
export(String) var input_display:String         = ""
export(String) var input_null_display_value     = ""
export(String) var input_script:String          = ""

var input_value                                 = "" setget set_input_value
var script_object

func _ready()->void:
	self.set_tooltip(input_description)
	add_to_group('input_field')
	
# set function
func set_input_value(new_value):
	input_value = new_value
	emit_signal("input_value_changed")
