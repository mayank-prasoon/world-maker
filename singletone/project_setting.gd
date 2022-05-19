extends Node

# === NODES ===
onready var shortcut_settings = $ShortcutSettings

# === VARIABLES ===
var save_file_location:String = "/project_settings.tres"
var project_save_template     = preload("res://assets/file templates/editor_setting_system_template/project_settings_template.gd").new()

var default_keybinding:Dictionary = {
			"command line interface" : preload("res://assets/default_shortcut/default_command_line_interface.tres"),
			"fullscreen"             : preload("res://assets/default_shortcut/default_fullscreen.tres")
	}

# === SETTINGS ===

# basic imformation
export(String) var project_name
export(String) var project_version
export(String) var date_of_creation
export(String) var project_location

# shortcut
export(Dictionary) var shortcuts:Dictionary
export(Dictionary) var visual_settings:Dictionary

# mods and addons
export(Array,Dictionary) var addons

# === SIGNALS ===
signal load_data


func _ready()->void:
	Logger.info(name + " - " + "Node loadded")

func open_project()->void:
	Logger.info(name + " - " + "open_project()")
	open_file()
	SystemDataManager.load_root_folder_paths()
	folder_integrity()
	emit_signal("load_data")


func save_file()->void:
	CommandSystem.API.echo("saved project settings")
	project_save_template.project_name     = project_name
	project_save_template.project_version  = project_version
	project_save_template.date_of_creation = date_of_creation
	project_save_template.project_location = project_location
	
	project_save_template.shortcuts        = shortcuts
	project_save_template.visual_settings  = visual_settings

	var _error = ResourceSaver.save(self.project_location + save_file_location, project_save_template)

func folder_integrity()->void:
	var dir = Directory.new()
	if !dir.dir_exists(SystemDataManager.root_save_file_path):
		dir.make_dir_recursive(SystemDataManager.root_save_file_path)

	if !dir.dir_exists(ProjectSettingsManager.project_location + '/assets'):
		dir.make_dir_recursive(ProjectSettingsManager.project_location + '/assets')

	if !dir.dir_exists(SystemDataManager.root_pin_save_path.get_base_dir()):
		dir.make_dir_recursive(SystemDataManager.root_pin_save_path.get_base_dir())

	if !dir.dir_exists(SystemDataManager.root_pin_temp_save_path.get_base_dir()):
		dir.make_dir_recursive(SystemDataManager.root_pin_temp_save_path.get_base_dir())

	if !dir.dir_exists(SystemDataManager.root_map_save_path.get_base_dir()):
		dir.make_dir_recursive(SystemDataManager.root_map_save_path.get_base_dir())

	if !dir.dir_exists(SystemDataManager.root_article_save_path.get_base_dir()):
		dir.make_dir_recursive(SystemDataManager.root_article_save_path.get_base_dir())
	
	if !dir.dir_exists(SystemDataManager.root_temp_save_path.get_base_dir()):
		dir.make_dir_recursive(SystemDataManager.root_temp_save_path.get_base_dir())


func open_file()->void:
	CommandSystem.API.echo("opened project settings")
	var resource = ResourceLoader.load(self.project_location + save_file_location)

	project_name     = resource.project_name
	project_version  = resource.project_version
	date_of_creation = resource.date_of_creation 
	project_location = resource.project_location

	shortcuts        = resource.shortcuts
	visual_settings  = resource.visual_settings

func save_project_settings():
	save_file()
