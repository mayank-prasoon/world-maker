extends Control

signal input_value_changed

var input_value = '' setget set_input_value, get_input_value

func _ready():
	add_to_group('map_inspector_input_field')

func set_input_value(value):
	input_value = value
	emit_signal("input_value_changed")

func get_input_value():
	return input_value
