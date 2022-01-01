extends Control


func _ready():
	pass


func _on_SettingsButton_pressed():
	var _x = get_tree().change_scene_to(load("res://systems/setting_menu/SettingMenu.tscn"))


func _on_ShortcutButton_pressed():
	var _x = get_tree().change_scene_to(load("res://systems/shortcut_menu/ShortcutMenu.tscn"))


