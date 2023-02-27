
# ============================================================================ #
#                            IMAGE RELATED UTILITIES                           #
# ============================================================================ #

# these funcs and sub classes are related to image related uitilites like 
# loading and resizing of those images


class_name ImageUtilities
extends RefCounted

#                            === SUB CLASS ===

# load images checked main thread
class ImageLoader extends Resource:

	# locad images
	static func load_image(image_path:String)->Image:
		var new_image:Image = Image.new()
		var file_checker = ResourceLoadSystem.FileChecker
		if file_checker.check_file_exists(image_path) == OK:
			var _error:int = new_image.load(image_path)
			new_image.fix_alpha_edges()

		return new_image

# ------------------------------------------------------------------------------

	# load image texture
	static func load_image_texture(image_path:String, flag:int = Texture2D.FLAGS_DEFAULT)->ImageTexture:
		var new_texture:ImageTexture = ImageTexture.new()
		var file_checker = ResourceLoadSystem.FileChecker
		if file_checker.check_file_exists(image_path) == OK:
			new_texture.create_from_image(load_image(image_path)) #,flag
		
		return new_texture

# ------------------------------------------------------------------------------

# change the image size
class ImageResize extends RefCounted:

	# image type
	enum {
		ICON,
		MAP_PIN,
		THUMBNAIL,
		ARTICLE_PROFILE,
	}

# ------------------------------------------------------------------------------

	# resize the image to specific image type
	static func resize_image(image_texture:ImageTexture, image_type:int)->ImageTexture:
		var selected_size:Vector2 = Vector2(0, 0)

		match image_type:
			ICON:
				selected_size = Vector2(25, 25)
			MAP_PIN:
				selected_size = Vector2(125, 125)
			THUMBNAIL:
				selected_size = Vector2(250, 140)
			ARTICLE_PROFILE:
				selected_size = Vector2(250, 250)

		image_texture.set_size_2d_override(selected_size)

		return image_texture

# ------------------------------------------------------------------------------

	# resize image to specific size
	static func resize_image_to(image_texture:ImageTexture, new_image_size:Vector2)->ImageTexture:
		image_texture.set_size_2d_override(new_image_size)
		return image_texture

# ------------------------------------------------------------------------------

# This sub class deals with loading resource checked differnt thread:
class ThreadLoad extends Object:
	signal resource_loaded(resource)

	var thread:Thread = Thread.new()

	# initialize the class
	func _init(object,method:String,resource_path:String):
		var _1 = self.connect("resource_loaded",Callable(object,method))

		var _2 = thread.start(
			self,
			'load_on_thread',
			resource_path
		)

	# load resources
	func load_on_thread(path:String)->Resource:
		var resource:Resource = ImageLoader.load_image_texture(path)
		self.call_deferred("join_thread")
		return resource
	
	# free self and join the thread with the 
	func join_thread()->void:
		var resource = thread.wait_to_finish()
		self.emit_signal("resource_loaded", resource) # recived by main class
		self.free()

# ------------------------------------------------------------------------------

#                             === METHODS ===

# load image
static func load_image(image_path:String)->ImageTexture:
	var image_texture:ImageTexture = ImageTexture.new()
	if ResourceLoadSystem.FileChecker.check_file_exists(image_path) == OK:
		image_texture = ImageLoader.load_image_texture(image_path)
	return image_texture

# load image checked thread
static func load_image_on_thread(object, method:String, image_path:String)->void:
	if ResourceLoadSystem.FileChecker.check_file_exists(image_path) == OK:
		var _thread_load:ThreadLoad = ThreadLoad.new(object, method, image_path)
