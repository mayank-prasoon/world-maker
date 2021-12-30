extends "res://addons/gut/test.gd"

func before_each():
	var dir = Directory.new()
	dir.remove("res://project_settings.tres")

func test_remap_input():
	

	
	var x:Node = load("res://singletone/ProjectSetting.tscn").instance()
	add_child_autofree(x)
	
	assert_eq_deep(x.shortcuts, {
			"command line interface" :preload("res://assets/default_shortcut/default_command_line_interface.tres"),
			"full screen"            :preload("res://assets/default_shortcut/default_fullscreen.tres")
	})

	x.shortcut_settings.remap_input(
			"command line interface",
			load("res://test/resources_and_temp_items/command_line_shortcut.tres")
		)

	assert_eq_deep(x.shortcuts, {
			"command line interface" :load("res://test/resources_and_temp_items/command_line_shortcut.tres"),
			"full screen"            :preload("res://assets/default_shortcut/default_fullscreen.tres")
	}
	)

func test_delete_old_keys():
	var x:Node = load("res://singletone/ProjectSetting.tscn").instance()
	add_child_autofree(x)
	x.shortcut_settings.delete_old_keys()
	assert_eq(InputMap.get_action_list("command line interface").size(), 0)


	x.shortcut_settings.remap_input(
		"command line interface",
		load("res://test/resources_and_temp_items/command_line_shortcut.tres")
	)
	
	assert_eq(InputMap.get_action_list("command line interface")[0].scancode, 84)
