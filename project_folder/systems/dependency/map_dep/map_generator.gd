class_name MapGen
extends Reference

class MapChunkSaver extends Object:
	var thread = Thread.new() 
	# saves texture
	func _init(path:String, chunk:Image) -> void:
		thread.start(
			self,
			'save_chunk',
			[path, chunk]
		)

	func save_chunk(args) -> void:
		var path:String = args[0]
		var chunk:Image = args[1]

		var _error:int = chunk.save_png(path)
		self.call_deferred('join_thread')

	func join_thread() -> void:
		LoadingSystem.call_deferred('add_value', 1)
		thread.wait_to_finish()
		self.call_deferred("free")


# get the number of chunk
static func get_chunk_count(image_size:Vector2, chunk_size:Vector2)->int:
	var image_rect:float = Rect2(Vector2(0,0), image_size).get_area()
	var chunk_rect:float = Rect2(Vector2(0,0), chunk_size).get_area()
	
	var chunk_count:float = image_rect/chunk_rect
	
	return int(round(chunk_count))


#                 === DANGER ZONE ===                   #
# ----------------------------------------------------- #
#    following code are depricated or need a overhaul   #
#                or a work in progress                  #
#                                                       #
#              !!PROCEED WITH CAUTION!!                 #
#                                                       #


# slice the texture into tile set
static func generate_map(map_name:String, texture_path:String, chunk_size:Vector2 = Vector2(512, 288))->void:
	var image:Image           = ImageHandler.load_image(texture_path)
	var chunk_count:int       = get_chunk_count(image.get_size(), chunk_size)
	var map_chunks:Array      = []

	var image_dimension:int = int(sqrt(chunk_count))

	for y_axis in range(image_dimension):
		for x_axis in range(image_dimension):
			map_chunks.append(
					make_texture(
						image,
						chunk_size,
						x_axis,
						y_axis
				)
			)
	
	# create a new map
	ResourceManager.save_file(
			{
				"map_name"     : map_name,
				"map_chunks"   : map_chunks,
				"chunk_size"   : chunk_size,
				"chunk_number" : chunk_count
			},
			
			ResourceManager.MAP
		)


# genereate and save map fragments
static func make_texture(image:Image, chunk_size:Vector2, index_x:int, index_y:int)->String:

	# genrate position
	var position:Vector2 = Vector2(
				chunk_size.x * index_x,
				chunk_size.y * index_y
			)

	# create new image form slice
	var new_image:Image = Image.new()
	new_image.create(
		int(round(chunk_size.x)),
		int(round(chunk_size.y)),
		false,
		image.get_format()
	)

	new_image.blit_rect(
			image,
			Rect2(
				position,
				chunk_size
			),
			Vector2(0,0)
	)

	var _i = new_image.generate_mipmaps()

	var path = SystemDataManager.root_save_file_path + \
	"/map_chunks/{uuid}_save_data.png".format({"uuid" : UUID.generate()})
	
	# save the image on the disk
	var _x = MapChunkSaver.new(path, new_image)

	return path
