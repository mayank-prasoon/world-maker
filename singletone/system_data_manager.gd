extends Node

# === EXPORTS ===

# paths
var root_save_file_path
var root_map_save_path
var root_pin_save_path
var root_article_save_path
var root_temp_save_path

# === VERIABLES ===
func _ready():
	root_save_file_path    = SystemSettings.current_path + '/save_files'
	
	# sub resource path
	root_map_save_path     = self.root_save_file_path + '/maps/{uuid}_save_data.tres'
	root_pin_save_path     = self.root_save_file_path + '/pins/{uuid}_save_data.tres' 
	root_article_save_path = self.root_save_file_path + '/articles/{uuid}_save_data.tres' 
	root_temp_save_path    = self.root_save_file_path + '/templates/{uuid}_template.tres'
 
# verify paths and check the intrigity of the folder system
func verify(path:String, resource_type:int, uuid:String) -> void:
	Logger.info("verifing file intregity of {0} of type {1} - file_path: {3}".format([resource_type, path]))
	var file:File = File.new()
	if !file.file_exists(path):
		Logger.info("!file is missing! - new file is being created")
		if !file.file_exists(path.get_base_dir()):
			var dir:Directory = Directory.new()
			var _x = dir.make_dir_recursive(path.get_base_dir())

			match resource_type:
				ResourceManager.MAP:
					ResourceManager.save_file(
						{'map_name':uuid},
						ResourceManager.MAP
					)

				ResourceManager.PIN:
					ResourceManager.save_file(
						{'pin_id':uuid},
						ResourceManager.PIN
					)

