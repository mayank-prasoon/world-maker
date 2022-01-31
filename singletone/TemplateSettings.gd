extends Node

enum TYPE {
	base,
	map,
	pin
}

func get_all_template()->Array:
	var save_location:String = SystemDataManager.root_save_file_path + "/templates/"
	var templates = []
	
	var folder      = Directory.new()
	var base_folder = save_location
	if folder.dir_exists(base_folder):
		folder.open(base_folder)
		folder.list_dir_begin()
		while true:
			var file = folder.get_next()
			if file == "":
				break
			elif not file.begins_with("."):
				var temp_template = base_folder + "/" + file
				templates.append(temp_template)
		folder.list_dir_end()

	return templates


func get_template(type:int)->Array:
	var temp_templates:Array = []

	var templates:Array = get_all_template()
	for i in templates:
		var template = load(i).new()
		if template.template_type == type:
			temp_templates.append(template)

	return temp_templates
