extends Control

# === NODES ===

onready var reset:   = $"Background/HBoxContainer/Reset"
onready var zoomIn:  = $"Background/HBoxContainer/ZoomIn"
onready var zoomOut: = $"Background/HBoxContainer/ZoomOut"

# === SIGNALS ==

func _on_Increase_pressed() -> void:
# it is emited when ZoomIn button is pressed and inceases the zoom of the map
	get_tree().call_group('camera_movement', 'cameraZoomIn')
	zoomIn.focus_mode = Control.FOCUS_NONE


func _on_Decrese_pressed() -> void:
# it is emited when ZoomOut button is pressed and deceases the zoom of the map
	get_tree().call_group('camera_movement', 'cameraZoomOut')
	zoomOut.focus_mode = Control.FOCUS_NONE


func _on_Reset_pressed() -> void:
# it is emited when ZoomOut button is pressed and reset the zoom of the map
	get_tree().call_group('camera_movement', 'cameraReset')
	reset.focus_mode = Control.FOCUS_NONE

