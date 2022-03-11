extends RootFieldInput

# export(String) var input_value:String           = ""

func _ready()->void:
	$VBoxContainer/Label.text = input_name

	$VBoxContainer/HBoxContainer/LineEdit.text = input_value
	$VBoxContainer/Image.texture               = load(input_value)

func display()->String:
	var image:Image = Image.new()
	var _error      = image.load(input_value)
	if !(input_value == ""):
		return input_display.format(
			{
				'value' : "[img={width}x{height}]{path}[/img]".format(
					{
						"width" : image.get_width(),
						"height": image.get_height(),
						"path"  : input_value
					}
				)
			}
		)
	else:
		return input_display.format({'value' : input_null_display_value})
		


func _on_FileDialog_file_selected(path):
	set_input_value(path)
	$VBoxContainer/Image.texture               = load(input_value)
	$VBoxContainer/HBoxContainer/LineEdit.text = input_value


func _on_LineEdit_text_changed(new_text):
	set_input_value(new_text)
	$VBoxContainer/Image.texture = load(input_value)


func _on_Browse_pressed():
	$FileDialog.popup_centered()
