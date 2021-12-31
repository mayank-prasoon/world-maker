extends Control


func _ready():
	Logger.info(name + " - " + "node loaded")
	$NewProject.visible    = false
	$VBoxContainer.visible = true


func _on_NewProjectButton_pressed():
	Logger.info(name + " _on_NewProjectButton_pressed()")
	$NewProject.visible    = true
	$VBoxContainer.visible = false


func _on_Button2_pressed():
	Logger.info(name + " _on_Button2_pressed()")
	$NewProject.visible    = false
	$VBoxContainer.visible = true


func _on_OpenProjectButton_pressed():
	Logger.info(name + " _on_OpenProjectButton_pressed()")
	$FileDialog.popup_centered()


func _on_FileDialog_dir_selected(dir):
	Logger.info(name + " _on_FileDialog_dir_selected({0})".format([dir]))	
	pass
