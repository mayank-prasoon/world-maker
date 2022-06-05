class_name RootSystemTest
extends Reference

var sub_folders:Array = [
		"pins",
		"maps",
		"articles",
		"map_symbol_templates"
]

func clean_system_save_files():
	var folder:Directory = Directory.new()
	var base_folder:String = "res://save_files/"

	for x in sub_folders:
		var new_folder = base_folder + x
		if folder.dir_exists(new_folder):
			var _x = folder.open(new_folder)
			var _y = folder.list_dir_begin()
			while true:
				var file = folder.get_next()
				if file == "":
					break
				elif not file.begins_with("."):
					var _z = folder.remove(new_folder + '/' + file)
			folder.list_dir_end()
