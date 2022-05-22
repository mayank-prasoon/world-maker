extends "res://systems/map_system/ui_elements/map_pin_inspector/inspector_input.gd"

func _ready()->void:
	set_input_value(get_owner().resource_file.pin_article)

func _on_OptionButton_text_changed(new_text):
	var dir = Directory.new()
	if dir.file_exists(new_text):
		set_input_value(load(new_text))
