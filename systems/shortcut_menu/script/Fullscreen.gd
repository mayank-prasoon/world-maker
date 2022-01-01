extends HBoxContainer

export(String) var action_name

func _ready():
	var _x = $Button.connect("pressed", self, 'open_remap_dialog')

func open_remap_dialog():
	var remap_dialog = get_parent().get_parent().get_node("ShortcutRemapDialog")
	remap_dialog.popup_centered()
	remap_dialog.action_name = action_name
	remap_dialog.i = true
