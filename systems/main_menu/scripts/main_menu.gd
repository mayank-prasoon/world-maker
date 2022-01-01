extends Control


func _ready():
	Logger.info(name + " - " + "node loaded")
	$NewProject.visible    = false
	$OpenProject.visible   = false
	$VBoxContainer.visible = true


func _on_NewProjectButton_pressed():
	Logger.info(name + " _on_NewProjectButton_pressed()")
	$NewProject.visible    = true
	$OpenProject.visible   = false
	$VBoxContainer.visible = false


func _on_Button2_pressed():
	Logger.info(name + " _on_Button2_pressed()")
	$NewProject.visible    = false
	$OpenProject.visible   = false
	$VBoxContainer.visible = true

	for x in $OpenProject/VBoxContainer.get_children():
		x.queue_free()

func _on_OpenProjectButton_pressed():
	Logger.info(name + " _on_OpenProjectButton_pressed()")
	$NewProject.visible    = false
	$OpenProject.visible   = true
	$VBoxContainer.visible = false

	$OpenProject.add_projects()
			 
func _on_FileDialog_dir_selected(dir):
	Logger.info(name + " _on_FileDialog_dir_selected({0})".format([dir]))
