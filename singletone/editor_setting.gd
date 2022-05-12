extends Node

# === VARIABLES ===

var editor_settings_save_location:String   = "user://settings.tres"
var settings:EditorSettingsTemplate        = EditorSettingsTemplate.new()

var current_path:String = "user://"

func _ready()->void:
	Logger.info(name + " loaded")
	var file = File.new()
	if !file.file_exists(editor_settings_save_location):
		var _x = ResourceSaver.save(editor_settings_save_location, settings)
	else:
		settings = ResourceLoader.load(editor_settings_save_location)
	current_path = "user://"

# === project ===

func get_projects()->Array:
	Logger.info(name + " - " + "get_projects()")
	var x = settings.project_list
	return x

func add_new_project(project_name:String, project_path:String):
	Logger.info(name + " - " + "get_pinned_project({0},{1})".format([project_name,project_path]))
	settings.project_list.append({project_name : project_path})
	var _x = ResourceSaver.save(editor_settings_save_location, settings)


func remove_project(project_name:String, project_path:String):
	Logger.info(name + " - " + "remove_project({0},{1})".format([project_name,project_path]))
	
	var index = -1

	for x in settings.project_list.size():
		if str(settings.project_list[x]) == str({project_name : project_path}):
			index = x

	if index != -1:
		settings.project_list.remove(index)
		var _x = ResourceSaver.save(editor_settings_save_location, settings)
		Logger.info(name + " - " + "remove_project({0},{1})".format([project_name,project_path]))
	else:
		Logger.info(name + " - " + "remove_project({0},{1})".format([project_name,project_path]) + " aborted")
		Logger.error(name + " - " + "{0} : {1} could not be found".format([project_name,project_path]))

# === last project ===

func last_project()->Dictionary:
	Logger.info(name + " - " + "last_project()")
	var x = settings.last_project 
	return x

func add_last_project(project_index:int):
	Logger.info(name + " - " + "add_last_project({0})".format([project_index]))
	settings.last_project = settings.project_list[project_index]
	var _x = ResourceSaver.save(editor_settings_save_location, settings)

# === pinned project ===

func get_pinned_project() -> Array:
	Logger.info(name + " - " + "get_pinned_project()")
	var x = settings.pinned_projects 
	return x
	

func pin_project(project_index:int) -> void:
	if settings.pinned_projects.find(project_index) == -1:
		Logger.info(name + " - " + "pin_project({0})".format([project_index]))
		settings.pinned_projects.append(project_index)
		var _x = ResourceSaver.save(editor_settings_save_location, settings)


func upin_project(project_index) -> void:
	var x = settings.pinned_projects.find(project_index)
	if x != -1:
		settings.pinned_projects.remove(x)
		Logger.info(name + " - " + "remove_pin_project({0})".format([project_index]))

# === SIGNALS ===

func open_project(index:int):
	current_path = self.get_projects()[index]["path"]
