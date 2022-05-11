extends "res://systems/map_system/ui_elements/map_pin_inspector/inspector_input.gd"

func _ready():
	input_value = get_owner().resource_file.pin_name

func _on_LineEdit_text_changed(new_text):
	set_input_value(new_text)
