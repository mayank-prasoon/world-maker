class_name RootSystemTest
extends "res://addons/gut/test.gd"

var test_scene

var sub_folders:Array = [
		"pins",
		"maps",
		"map_chunks",
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
					gut.p("[color=#e51e48][Removed]: {file}[/color]".format({"file" : (new_folder + '/' + file)}))
			folder.list_dir_end()

func before_all():
	gut.p("\n=>\t[color=#e6d11d]### SYSTEM TESTS ###[/color]")
	clean_system_save_files()

func after_each():
	clean_system_save_files()
	gut.p('\n')
