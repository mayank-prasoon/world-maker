extends Control

func add_projects():
	for x in SystemSettings.get_projects():
		var project  = ProjectButton.new()
		project.project_name = x.keys()[0]
		project.path = x.values()[0]
		$VBoxContainer.add_child(project)


func _on_Browse_pressed():
	$FileDialog.popup_centered()
