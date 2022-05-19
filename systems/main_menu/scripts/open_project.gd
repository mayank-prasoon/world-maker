extends Control

#	elif SystemSettings.last_project() == 0:
#		pass
#	elif SystemSettings.last_project() == null:
#		pass

func add_projects():
	for x in SystemSettings.get_projects():
		var project  = ProjectButton.new()
		project.project_name = x.keys()[0]
		project.path = x.values()[0]
		$VBoxContainer.add_child(project)


func _on_Browse_pressed():
	$FileDialog.popup_centered()


func _on_FileDialog_dir_selected(dir):
	var file = File.new()
	if file.file_exists(dir + "/project_settings.tres"):
		var project = load(dir + "/project_settings.tres")
		SystemSettings.add_new_project(project.project_name, dir)

	for x in $VBoxContainer.get_children():
		x.queue_free()

	add_projects()
