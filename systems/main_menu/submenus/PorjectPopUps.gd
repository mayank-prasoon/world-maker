extends Control

onready var projectNameDialog =  self.get_child(1)
onready var fileDialog = self.get_child(0)
onready var projectLineEdit = $ProjectName/LineEdit

var _select_name:bool = true
var _project_location:String 

func _on_FileDialog_dir_selected(dir:String)->void:
	if _select_name: 
		projectNameDialog.popup()
	_project_location = dir

func setFileDialogName(task_name:String)->void:
	fileDialog.dialog_text = task_name

func popUpFileDialog(new_project:bool=true)->void:
	fileDialog.popup_centered()
	_select_name = new_project

func _on_Button_pressed() -> void:
	_create_project_folder()
	var _change: = get_tree().change_scene("res://Scene/tab_menu/Tabs.tscn")

func _create_project_folder() -> void:
	print(_project_location + '/' + projectLineEdit.text)

func _create_open_project() -> void:
	print(_project_location)
