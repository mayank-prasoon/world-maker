extends Node

signal save_file

var default_keybinding:Dictionary = {
			"command line interface" : preload("res://assets/default_shortcut/default_command_line_interface.tres"),
			"fullscreen"             : preload("res://assets/default_shortcut/default_fullscreen.tres")
	}


func _ready()->void:
	Logger.info(name + " - " + "Node loadded")
	var _x = connect("save_file", self.get_parent(), "save_project_settings")


func delete_old_keys()->void:
	Logger.info(name + " - " + "delete_old_keys()")
	#Remove the old keys
	for i in get_parent().shortcuts:
		InputMap.action_erase_events(i)
		CommandSystem.API.echo("all the shortcut of " + i + " has been deleted")
		

func setup_keys() -> void:
	Logger.info(name + " - " + "setup_keys()")
	for i in get_parent().shortcuts:
		var newkey = get_parent().shortcuts[i]
		InputMap.action_add_event(i, newkey)
		CommandSystem.API.echo(str(newkey) + " added")


func remap_input(action_name:String, event:InputEvent)->void:
	Logger.info(name + " - " + "remap_input({0},{1})".format([action_name, event]))
	# delete old keys
	var newkey = get_parent().shortcuts[action_name]
	InputMap.action_erase_event(action_name, newkey)
	# create new keys
	InputMap.action_add_event(action_name, event)

	var _text = event.as_text()
	get_parent().shortcuts[action_name] = event
	CommandSystem.API.echo("new input for " + action_name + " : " + _text)
	emit_signal("save_file")


func default_keys():
	Logger.info(name + " - " + "default_back()")
	_on_ProjectSetting_load_data()


func _on_ProjectSetting_load_data():
	delete_old_keys()
	setup_keys()
