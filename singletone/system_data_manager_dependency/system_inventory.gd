extends Node

func _ready():
	get_parent().root_save_file_path = SystemSettings.current_path + "/save_files"
