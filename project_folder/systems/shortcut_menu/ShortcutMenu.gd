extends Control


func _ready():
	for x in ProjectSettingsManager.shortcuts.size():
		var y = self.get_child(0).get_child(x)
		y.action_name             = ProjectSettingsManager.shortcuts.keys()[x]
		y.get_node("Label").text  = ProjectSettingsManager.shortcuts.keys()[x]
		y.get_node("Button").text = ProjectSettingsManager.shortcuts[ProjectSettingsManager.shortcuts.keys()[x]].as_text()


func _on_Back_pressed():
	var _x = get_tree().change_scene_to_packed(load("res://systems/system_menu/SystemMenu.tscn"))


func _on_Save_pressed():
	pass # Replace with function body.
