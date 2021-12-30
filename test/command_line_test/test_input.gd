extends Node


func _init():
	ProjectSettingsManager.shortcut_settings.remap_input("command line interface", load("res://test/resources_and_temp_items/command_line_shortcut.tres"))
