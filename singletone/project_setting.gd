extends Node

# === INNER CLASS ===

class ProjectSaveTemplate:
	extends Resource
	
	# basic imformation
	export(String) var project_name
	export(String) var project_version
	export(String) var date_of_creation
	export(String) var project_location
	
	# shortcuts
	export(InputEventKey) var open_command_line

	# settings

# === VARIABLES ===
var save_file_location:String = "/project_settings.tres"
var project_save_template

# === SETTINGS ===

# basic imformation
export(String) var project_name
export(String) var project_version
export(String) var date_of_creation
export(String) var project_location

#shortcut
export(InputEventKey) var open_command_line

func _ready():
	project_save_template = ProjectSaveTemplate.new()
	save_file()

func save_file():
	var _error = ResourceSaver.save(SystemSettings.current_path + save_file_location, project_save_template)
	print(_error)


