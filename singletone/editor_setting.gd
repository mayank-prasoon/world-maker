extends Node

# === VARIABLES ===

var editor_settings_save_location:String   = "user://settings.tres"
var settings:EditorSettingsTemplate        = EditorSettingsTemplate.new()

var current_path:String = "res://"

func _ready()->void:
	editor_settings_file_handler()

# === project ===

# handles the settings file for the editor
func editor_settings_file_handler()->void:
	if !check_if_editor_settings_file_exists():
		# create a editor settings file if it doesn't exists
		var _x = ResourceSaver.save(editor_settings_save_location, settings)
	else:
		# load settings file
		settings = ResourceLoader.load(editor_settings_save_location)

# check if editor settings file - user://settings.tres exists
func check_if_editor_settings_file_exists()->bool:
	var file = File.new()
	if file.file_exists(editor_settings_save_location):
		return true
	else:
		return false

# get project list from settings.tres
func get_projects()->Array:
	Logger.info(name + " - " + "get_projects()")
	var project_list = settings.project_list
	return project_list

# add a new project to list projects in settings.tres
func add_new_project(project_name:String, project_path:String):
	Logger.info(name + " - " + "get_pinned_project({0},{1})".format([project_name,project_path]))
	settings.project_list.append({project_name : project_path})
	var _x = ResourceSaver.save(editor_settings_save_location, settings)

# remove project from project list from settings.tres
func remove_project(project_name:String, project_path:String):
	Logger.info(name + " - " + "remove_project({0},{1})".format([project_name,project_path]))

	var index = -1

	for x in settings.project_list.size():
		if str(settings.project_list[x]) == str({project_name : project_path}):
			index = x

	# check if the last project is same as the project which is to be deleted
	if last_project().hash() == {project_name:project_path}.hash():
		settings.last_project = null

	if index != -1:
		settings.project_list.remove(index)
		var _x = ResourceSaver.save(editor_settings_save_location, settings)


# === last project ===

# fetch the last project
func last_project()->Dictionary:
	Logger.info(name + " - " + "last_project()")
	var x = settings.last_project 
	return x

func add_last_project(project_index:int):
	Logger.info(name + " - " + "add_last_project({0})".format([project_index]))
	settings.last_project = settings.project_list[project_index]
	var _x = ResourceSaver.save(editor_settings_save_location, settings)

func add_last_project_by_name(project_name:String, project_location:String)->void:
	var dic = {project_name : project_location}
	settings.last_project = dic
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
