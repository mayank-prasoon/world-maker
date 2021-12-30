extends Control

onready var filedialog: = $FileDialog
onready var parent: = $"../.."

func _on_TextureRect2_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.is_pressed():
			filedialog.popup_centered()


func _on_FileDialog_file_selected(path: String) -> void:
	$TextureRect/TextureRect3.hide()
	$TextureRect/TextureRect2.hide()
	
	parent.mapTexture = ResourceLoader.load(path)
	parent.mapTextureLocation = path
	$TextureRect2.texture = parent.mapTexture
	$"../../New".disabled = false
