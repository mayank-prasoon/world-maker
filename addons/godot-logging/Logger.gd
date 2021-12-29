tool
extends EditorPlugin

func _enter_tree():
	add_custom_type("Logger", "Node", preload("log_base.gd"), preload("Logging.png"))

func _exit_tree():
	remove_custom_type("Logger")
