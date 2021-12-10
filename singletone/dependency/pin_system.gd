extends Node

# this script deals with single file

# save file
func _save_file(
		pin_name:String,
		template:Resource   = MapSymbolTemplate.new(),
		location:Vector2    = Vector2(0,0),
		article:Resource    = Resource.new(),
		link_state:bool     = false,
		chunk_link:Resource = MapChunkData.new()
	) -> void:

	var newSavePin                  = get_parent().mapPin.new()
	newSavePin.pin_name             = pin_name
	newSavePin.pin_symbol_template  = template
	newSavePin.pin_location         = location
	newSavePin.pin_article          = article
	newSavePin.map_link_state       = link_state
	newSavePin.linked_chunk         = chunk_link

	var _x = ResourceSaver.save(
		get_parent().savePinData.format({"pin_name": pin_name}),
		newSavePin
	)

# open file
func _open_file(pin_name:String)->Resource:
	get_parent().verify(
		get_parent().savePinData.format({"pin_name": pin_name}),
		get_parent().MAP_RESOURCE_TYPE.PIN, pin_name
	)
	
	var newSavePin = ResourceLoader.load(get_parent().savePinData.format({"pin_name": pin_name}))
	return newSavePin

# remove all file
func _remove_all_file() -> void:
	var folder = Directory.new()
	var base_folder = get_parent().savePinData.get_base_dir()

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
