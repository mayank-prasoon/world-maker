extends RootFieldInput

# export var input_value: String:String           = ""

func _ready()->void:
	$VBoxContainer/Label.text = input_name

	$VBoxContainer/HBoxContainer/LineEdit.text = input_value
	$VBoxContainer/Image.texture               = load(input_value)

func display()->String:
	var image_resource = ImageHandler.load_image_texture(input_value)

	if !(input_value == ""):
		return input_display.format(
			{
				'value' : "[img]{path}[/img]".format(
					{
						"path"  : input_value
					}
				)
			}
		)
	else:
		return input_display.format({'value' : input_null_display_value})


func _on_FileDialog_file_selected(path:String)->void:
	create_cache(path)
	$VBoxContainer/Image.texture               = ResourceLoader.load(input_value)
	$VBoxContainer/HBoxContainer/LineEdit.text = input_value


func _on_LineEdit_text_changed(new_text:String)->void:
	create_cache(new_text)
	$VBoxContainer/Image.texture = ResourceLoader.load(input_value)

func create_cache(path:String)->void:
	var file = File.new()
	if file.file_exists(path):
		var cache_location = ProjectSettingsManager.project_location + '/assets/' + path.get_file().get_basename() + ".tres"
		set_input_value(cache_location)
		if !file.file_exists(cache_location):
			var image_resource = ImageHandler.load_image_texture(path)
			var _error = ResourceSaver.save(cache_location, image_resource)

func _on_Browse_pressed()->void:
	$FileDialog.popup_centered()
