extends HBoxContainer

func _ready()->void:
	pass

func _change_tab(index:int)->void:
	for button in get_children():
		button.button_pressed = false

	self.get_children()[index].button_pressed = true
