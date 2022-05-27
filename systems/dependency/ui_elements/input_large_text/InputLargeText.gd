extends "res://systems/map_system/ui_elements/map_element_inspector/inspector_input.gd"

#export(String) var input_value:String       = ""

func _ready()->void:
	input_value = get_owner().resource_file.comment_text

func _on_TextEdit_text_changed():
	set_input_value($VBoxContainer/TextEdit.get_text())
