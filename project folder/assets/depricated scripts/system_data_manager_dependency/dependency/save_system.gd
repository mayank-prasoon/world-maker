class_name SaveSystem
extends Reference

# WARNING:
# this signal is only ment to be emmited to call deffer in
# a multi-threaded instance
signal data_saved

# === VARIABLES ===

var save_location:String
var resource_type:int
var threads:Array


# saves the data in a resource file
# WARNING: This method is ment to be acess via thread
func save_data(args):
	var _x = ResourceSaver.save(args[0], args[1])
	call_deferred(
		"emit_signal", "data_saved"
	)

func open_file(item_uid:String)->Resource:
	
	SystemDataManager.verify(
		save_location.format({"uuid": item_uid}),
		resource_type, item_uid
		)

	# Logger.info(name + " - open_file({0})".format([item_uid]))
	CommandSystem.API.echo("{name} loaded".format({"name": item_uid}))

	var map = ResourceLoader.load(save_location.format({"uuid": item_uid}))
	return map


func remove_all_files():
	# Logger.info(name + " - remove_all_files()")

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
	# Logger.info(name + " - remove_file({0})".format([item_uid]))
	
	var file = Directory.new()
	file.remove(save_location.format({"uuid": item_uid}))

	CommandSystem.API.echo("removed files: {file}".format({"file": file}))
