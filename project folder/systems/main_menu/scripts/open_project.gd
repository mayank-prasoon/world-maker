# ============================================================================ #
#                               OPEN PROJECT                                   #
# ============================================================================ #

#
#             UI related to opening and importing projects
#

extends Control

# === methods ===

# add new project
func add_projects()->void:
	for x in SystemSettings.get_projects():
		var path = x.values()[0]

		# create the Project button if the path are valid
		if check_if_project_is_valid(path):
			var project  = ProjectButton.new()
			project.project_name = x.keys()[0]
			project.path = path
			$VBoxContainer.add_child(project)

# checks if the project is valid
func check_if_project_is_valid(path)->bool:
	var dir:Directory = Directory.new()
	if dir.dir_exists(path) and dir.file_exists(path+'/project_settings.tres'):
		if !(load(path+'/project_settings.tres') == null) :
			return true
		else:
			return false
	else:
		return false


# Import project and add it to project list
func import_project(dir)->void:
	if check_if_project_is_valid(dir):
		var project = load(dir + "/project_settings.tres")
		SystemSettings.add_new_project(project.project_name, dir)

	for x in $VBoxContainer.get_children():
		x.queue_free()

	add_projects()

# === Siganls ===

func _on_Browse_pressed():
	$FileDialog.popup_centered()


func _on_FileDialog_dir_selected(dir)->void:
	import_project(dir)
