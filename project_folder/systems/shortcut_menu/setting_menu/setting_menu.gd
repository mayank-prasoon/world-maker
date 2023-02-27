extends Control


func _ready():
	$VBoxContainer/ProjectName/LineEdit.text     = ProjectSettingsManager.project_name
	$VBoxContainer/ProjectLocation/LineEdit.text = ProjectSettingsManager.project_location
	$VBoxContainer/ProjectVersion/LineEdit.text  = ProjectSettingsManager.project_version

func _on_Back_pressed():
	var _x = get_tree().change_scene_to_packed(load("res://systems/system_menu/SystemMenu.tscn"))


func _on_Save_pressed():
	ProjectSettingsManager.project_name     = $VBoxContainer/ProjectName/LineEdit.text
	ProjectSettingsManager.project_location = $VBoxContainer/ProjectLocation/LineEdit.text
	ProjectSettingsManager.project_version  = $VBoxContainer/ProjectVersion/LineEdit.text
	ProjectSettingsManager.save_file()
