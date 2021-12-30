extends Control

onready var fileDialog: = $"../PorjectPopUps"

func _on_New_pressed()->void:
	fileDialog.setFileDialogName('Pick a folder to save your data')
	fileDialog.popUpFileDialog()


func _on_Open_pressed()->void:
	fileDialog.setFileDialogName('Pick a project folder folder')
	fileDialog.popUpFileDialog(false)
