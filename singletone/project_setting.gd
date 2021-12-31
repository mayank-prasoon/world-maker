extends Node

# === NODES ===
onready var shortcut_settings = $ShortcutSettings

# === VARIABLES ===
var save_file_location:String = "/project_settings.tres"
var project_save_template     = preload("res://assets/file templates/editor_setting_system_template/project_settings_template.gd").new()

# === SETTINGS ===

# basic imformation
export(String) var project_name
export(String) var project_version
export(String) var date_of_creation
export(String) var project_location

# shortcut
export(Dictionary) var shortcuts
export(Dictionary) var visual_settings

# mods and addons
export(Array,Dictionary) var addons

# === SIGNALS ===
signal load_data


func _ready():
	Logger.info(name + " - " + "Node loadded")
	var file = File.new()
	if !file.file_exists(SystemSettings.current_path + save_file_location):
		shortcuts = get_node("ShortcutSettings").default_value
		save_file()
	else:
		open_file()
	emit_signal("load_data")


func save_file():
	CommandSystem.API.echo("saved project settings")
	project_save_template.project_name     = project_name
	project_save_template.project_version  = project_version
	project_save_template.date_of_creation = date_of_creation
	project_save_template.project_location = project_location
	
	project_save_template.shortcuts        = shortcuts
	project_save_template.visual_settings  = visual_settings

	var _error = ResourceSaver.save(SystemSettings.current_path + save_file_location, project_save_template)


func open_file():
	CommandSystem.API.echo("opened project settings")
	var resource = ResourceLoader.load(SystemSettings.current_path + save_file_location)
	
	project_name     = resource.project_name
	project_version  = resource.project_version
	date_of_creation = resource.date_of_creation 
	project_location = resource.project_location

	shortcuts        = resource.shortcuts
	visual_settings  = resource.visual_settings

func save_project_settings():
	save_file()