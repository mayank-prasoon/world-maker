extends RootFieldInput

func _ready()->void:
	$VBoxContainer/Label.text                  = input_name
	$VBoxContainer/HBoxContainer/LineEdit.text = input_value

	self.set_tooltip(input_description)


func _on_LineEdit_text_changed(new_text):
	set_input_value(new_text)


func _on_Button_pressed():
	$FileDialog.popup_centered()


func _on_FileDialog_file_selected(path):
	set_input_value(path)


func _on_InputOpenFile_input_value_changed():
	$VBoxContainer/HBoxContainer/LineEdit.text = input_value


func _on_FileDialog_files_selected(paths:PackedStringArray):
	var combined_path = ", ".join(paths)
	$VBoxContainer/HBoxContainer/LineEdit.text = combined_path
