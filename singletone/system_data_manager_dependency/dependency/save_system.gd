class_name SaveSystem
extends Node

# === NODES ===
onready var root_node:Node = self.get_parent().get_parent()

# === VARIABLES ===

var save_location:String
var resource_type:int

func _save_file():
	pass

func open_file(item_uid:String)->Resource:
	root_node.verify(
		save_location.format({"uuid": item_uid}),
		resource_type, item_uid
	)
	
	return ResourceLoader.load(save_location.format({"uuid": item_uid}))

func remove_all_files():
	var folder = Directory.new()
	var base_folder = save_location.get_base_dir()

	if folder.dir_exists(base_folder):
		folder.open(base_folder)
		folder.list_dir_begin()
		while true:
			var file = folder.get_next()
			if file == "":
				break
			elif not file.begins_with("."):
				folder.remove(base_folder + '/' + file)
		folder.list_dir_end()
	
	CommandSystem.API.echo("all files removed in the {folder}".format({"folder": base_folder}))

func remove_file(item_uid:String) -> void:
	var file = Directory.new()
	file.remove(save_location.format({"uuid": item_uid}))
	CommandSystem.API.echo("removed files: {file}".format({"file": file}))
