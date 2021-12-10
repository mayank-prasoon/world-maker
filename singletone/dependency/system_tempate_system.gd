extends Node

# this script deals with single file

# save file
func _save_file(
		template_name:String,
		texture:String = "xyz",
		offset:Vector2 = Vector2(0,0),
		color:Color    = Color.white
	) -> void:

	var newSymbolName                  = get_parent().mapSymbolTemplate.new()
	newSymbolName.template_name        = template_name
	newSymbolName.template_offset      = offset
	newSymbolName.template_texture     = texture
	newSymbolName.template_color       = color

	var _x = ResourceSaver.save(
		get_parent().savePinTemplateData.format({"template_name": template_name}),
		newSymbolName
	)

# open file
func _open_file(template_name:String)->Resource:
	get_parent().verify(
		get_parent().savePinTemplateData.format({"template_name": template_name}),
		get_parent().MAP_RESOURCE_TYPE.PIN_TEMPLATE,
		template_name
	)
	
	var newSymbolName = ResourceLoader.load(get_parent().savePinTemplateData.format({"template_name": template_name}))
	return newSymbolName

# remove all file
func _remove_all_file() -> void:
	var folder = Directory.new()
	var base_folder = get_parent().savePinTemplateData.get_base_dir()

	if folder.dir_exists(base_folder):
		folder.open(base_folder)
		folder.list_dir_begin()
		while true:
			var file = folder.get_next()
			if file == "":
				break
			elif not file.begins_with("."):
				folder.remove(base_folder + '/' + file)
		folder.list_dir_end()

# removes file
func _remove_file(path:String) -> void:
	var file = Directory.new()
	file.remove(path)
