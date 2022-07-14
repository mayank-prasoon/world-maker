
# ============================================================================ #
#                             RESOURCE SAVE SYSTEM                             # 
# ============================================================================ #

#
# This deals with saving resources
#

class_name ResourceSaveSystem
extends Reference

#                              === SUB CLASS ===  

# this sub class save resources though thread 
class SaveThead extends Object:
	var thread = Thread.new()

	# initailization
	func _init(path, resource):
		thread.start(
			self,
			'save',
			[
				path,
				resource
			]
		)

	# save the resources
	func save(args):
		var path:String       = args[0] 
		var resource:Resource = args[1]

		var _error = ResourceSaver.save(
			path,
			resource
		)

		self.call_deferred('join_thread')

	# join the thread the free it self
	func join_thread():
		thread.wait_to_finish()                                                 # join the thread and wait for it to finish
		self.call_deferred("free")                                              # free the object in the ideal frame

# ------------------------------------------------------------------------------

# this sub class check for folder intregety
class CheckFolderIntregety extends Object:

	# check if the folder structure is valid 
	static func check(path:String)->void:
		var dir:Directory = Directory.new()
		if !dir.file_exists(path.get_base_dir()):
			create(path.get_base_dir())

	# if the the folder structure was not vaild create new folder
	static func create(path)->void:
		var dir:Directory = Directory.new()
		dir.make_dir_recursive(path)

# ------------------------------------------------------------------------------

# save resources
static func save_resource(path:String, resource:Resource)->void:
	CheckFolderIntregety.check(path)
	SaveThead.new(path, resource)
