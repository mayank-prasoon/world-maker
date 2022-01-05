extends Node

# === EXPORTS ===
var root_save_file_path

# === VERIABLES ===
const uuid_util = preload("res://utilities/godot-uuid-master/uuid.gd")

enum MAP_RESOURCE_TYPE {
	PIN,
	PIN_TEMPLATE,
	MAP,
	MAP_CHUNK,
	ARTICLE
}

func verify(path:String, _type:int, resource_name:String) -> void:
	Logger.info("verifing file intregity of {0} of type {1} - file_path: {3}".format([resource_name, _type, path]))
	var file:File = File.new()
	if !file.file_exists(path):
		Logger.info("!file is missing! - new file is being created")
		if !file.file_exists(path.get_base_dir()):
			var dir:Directory = Directory.new()
			var _x = dir.make_dir_recursive(path.get_base_dir())
		match _type:
			MAP_RESOURCE_TYPE.PIN:
				$PinSystem/SaveSystem.save_file("", resource_name)
			MAP_RESOURCE_TYPE.PIN_TEMPLATE:
				$SymbolTemplateSystem/SaveSystem.save_file(resource_name)
			MAP_RESOURCE_TYPE.MAP_CHUNK:
				$MapChunkSystem/SaveSystem.save_file("", resource_name)
			MAP_RESOURCE_TYPE.MAP:
				$MapSystem/SaveSystem.save_file(resource_name)
			MAP_RESOURCE_TYPE.ARTICLE:
				$ArticleSystem/SaveSystem.save_file("", resource_name)
