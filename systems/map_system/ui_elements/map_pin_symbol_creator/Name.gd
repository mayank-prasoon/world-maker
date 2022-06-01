extends VBoxContainer

signal value_changed

func _on_LineEdit_text_changed(_new_text):
	emit_signal("value_changed")
