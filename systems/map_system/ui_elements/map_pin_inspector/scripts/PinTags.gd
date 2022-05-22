extends "res://systems/map_system/ui_elements/map_pin_inspector/inspector_input.gd"

func _ready()->void:
	input_value = $HBoxContainer/LineEdit.text.split(', ')

func _on_LineEdit_text_changed(new_text:String)->void:
	set_input_value(new_text.split(', '))
