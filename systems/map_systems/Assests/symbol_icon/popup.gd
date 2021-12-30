extends PopupDialog

onready var parent = $"../.."

func _on_Button_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_RIGHT and event.is_pressed():
			self.popup()

func _physics_process(_delta: float) -> void:
	self.rect_position = Vector2(
		get_parent().rect_global_position.x - 40,
		get_parent().rect_global_position.y - 100
	)


func _on_Edit_button_down() -> void:
	var editIcon:Control = get_tree().get_nodes_in_group('edit_icon')[0]
	self.hide()
	editIcon.show()
	editIcon.playAnimation()
	editIcon.editIcon(
		parent.get_index(),
		parent.iconName,
		parent.type,
		parent.iconTexture,
		parent.iconColorTag,
		parent.textureOffset
	)
