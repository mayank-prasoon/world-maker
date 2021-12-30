extends Control


# === SIGNAL RESIVERS ===
func _on_Button_pressed() -> void:
# this is emited when the main menu button is clicked
	var _change: = get_tree().change_scene("res://Scene/tab_menu/Tabs.tscn")


# === USELESS CODE ===

#onready var reset:   = $"HBoxContainer/HBoxContainer/Reset"
#onready var zoomIn:  = $"HBoxContainer/HBoxContainer/ZoomIn"
#onready var zoomOut: = $"HBoxContainer/HBoxContainer/ZoomOut"

#
#func _on_Increase_pressed() -> void:
#	get_tree().call_group('camera_movement', 'cameraZoomIn')
#	zoomIn.focus_mode = Control.FOCUS_NONE
#
#
#func _on_Decrese_pressed() -> void:
#	get_tree().call_group('camera_movement', 'cameraZoomOut')
#	zoomOut.focus_mode = Control.FOCUS_NONE
#
#
#func _on_Reset_pressed() -> void:
#	get_tree().call_group('camera_movement', 'cameraReset')
#	reset.focus_mode = Control.FOCUS_NONE
