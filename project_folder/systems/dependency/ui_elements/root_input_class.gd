class_name RootFieldInput
extends Control

signal input_value_changed


@export var input_name: String:String            = ""
@export var input_description:String     = "" # (String, MULTILINE)
@export var input_display: String:String         = ""
@export var input_null_display_value: String     = ""
@export var input_script: String:String          = ""

var input_value                                 = "" : set = set_input_value
var script_object

func _ready()->void:
	self.set_tooltip(input_description)
	add_to_group('input_field')

# set function
func set_input_value(new_value)->void:
	input_value = new_value
	emit_signal("input_value_changed")
