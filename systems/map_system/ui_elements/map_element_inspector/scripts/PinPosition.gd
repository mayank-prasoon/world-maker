extends "res://systems/map_system/ui_elements/map_element_inspector/inspector_input.gd"

onready var x_axis = $HBoxContainer/HBoxContainer/HBoxContainer/SpinBox
onready var y_axis = $HBoxContainer/HBoxContainer/HBoxContainer2/SpinBox2

func _ready()->void:
	input_value = get_owner().resource_file.pin_location

func value_changed(_value)->void:
	set_input_value(
		Vector2(
			x_axis.value,
			y_axis.value
		)
	)
