extends Node

# === ADD SYSMBOL ===

func _input(event: InputEvent) -> void:
# This opens the dialog box on right click on the canvas
# [it is a global global input]
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == BUTTON_MASK_RIGHT:
				get_parent().addSymbol()
