#          === USE-CASE ===           #
#                                     #
# this scripts contains global method #
#  that deals with files and folder   #
#                                     #

class_name FolderManager
extends Node

# loop though folder and returns the file path in the form of array
static func fetch_files_from(base_folder:String, return_path:bool = false)-> Array:
	var folder:Directory = Directory.new()
	
	var resources:Array      = []
	
	# if the folder exists
	if folder.dir_exists(base_folder):
		# open the directory
		folder.open(base_folder)
		folder.list_dir_begin()
		
		# loop though the base folder
		while true:
			var file = folder.get_next()

			# if looped though all files
			if file == "":
				break

			# check if the file is hidden
			elif not file.begins_with("."):
				if return_path:
					resources.append(base_folder + "/" + file)
				else:
					resources.append(load(base_folder + "/" + file))

		# close the directory
		folder.list_dir_end()
	
	return resources
