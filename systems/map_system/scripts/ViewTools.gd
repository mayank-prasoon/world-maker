extends Control


func _on_ZoomIn_pressed():
	EventBus.emit_signal("zoom_in")


func _on_ZoomOut_pressed():
	EventBus.emit_signal("zoom_out")


func _on_Rest_pressed():
	EventBus.emit_signal("reset_zoom")
