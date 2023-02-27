
# ============================================================================ #
#                           RESOURCE LOADER SYSTEM                             # 
# ============================================================================ #

# this class deals with loading resources


class_name ResourceLoadSystem
extends Reference

#                                === SUB CLASS ===

# This sub class deals with loading resource on differnt thread:
class ThreadLoad extends Object:
	signal resource_loaded(resource)

	var thread:Thread = Thread.new()

	# initialize the class
	func _init(object, method:String, resource_path:String)->void:
		var _1 = self.connect("resource_loaded", object, method)

		var _2 = thread.start(
			self,
			'load_on_thread',
			resource_path
		)

	# load resources
	func load_on_thread(path:String)->Resource:
		var resource:Resource = ResourceLoader.load(path)
		self.call_deferred("join_thread")
		return resource
	
	# free self and join the thread with the 
	func join_thread()->void:
		var resource = thread.wait_to_finish()
		self.emit_signal("resource_loaded", resource) # recived by main class
		self.free()

# ------------------------------------------------------------------------------

# This sub class deals with checking if file exits 
class FileChecker extends Reference:
	
	enum {
		OK,
		NOT_FOUND,
		NOT_VALID
	}
	
	# check if a File the file exists
	static func check_file_exists(path:String)->int:
		var dir:Directory = Directory.new()
		if dir.file_exists(path):
			return OK
		else:
			return NOT_FOUND

# ------------------------------------------------------------------------------

# This sub class load resources on a single thread
class LoadResource extends Reference:

	# load Resources
	static func load_resource(path)->Resource:
		var resource:Resource = ResourceLoader.load(path)
		return resource

#                                 === METHODS ===

# load resources
func load_resources(path:String):
	var error = FileChecker.check_file_exists(path) # check if the file exists

	match error:
		FileChecker.OK:
			var resource = LoadResource.load_resource(path)
			return resource


# load reosource with thread
func load_resource_with_thread(object, method:String, path:String)->void:
	var error = FileChecker.check_file_exists(path) # check if the file exists

	match error:
		FileChecker.OK:
			var _1 = ThreadLoad.new(object, method, path)


