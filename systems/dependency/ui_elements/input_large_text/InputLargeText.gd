extends RootFieldInput

#export(String) var input_value:String       = ""

func _ready()->void:
	$VBoxContainer/Label.text = input_name

	$VBoxContainer/TextEdit.text = input_value

func display()->String:
	if !(input_value == ""):
		return input_display.format({"value" : input_value})
	else:
		return input_display.format({"value" : input_null_display_value})

func _on_TextEdit_text_changed():
	set_input_value($VBoxContainer/TextEdit.get_text())
