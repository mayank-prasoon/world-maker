extends Node

var threads:Array          = []
var mutex:Mutex            = Mutex.new()

var array_of_texture:Array = [] 

var counter:int      = 0

# load image
func load_image(image_path:String)->Image:
	var new_image = Image.new()
	new_image.load(image_path)

	return new_image

# slices image into small textures
func slice_texture(texture_path:String, chunk_size:Vector2 = Vector2(512, 288))->Array:
	array_of_texture = []
	
	var image:Image = load_image(texture_path)
	var image_size:Vector2 = image.get_size()

	var chunk_count     = Rect2(Vector2(0,0), image_size).get_area() / Rect2(Vector2(0,0), chunk_size).get_area()
	var chunk_dimension = sqrt(chunk_count)

	for current_layer in range(chunk_dimension):
		genrate_threads(chunk_dimension)
		start_threads(
			image.duplicate(),
			chunk_size,
			current_layer
		)


	return array_of_texture

# generate threads
func genrate_threads(number_of_threads:int)->void:
	for _i in range(number_of_threads):
		var t = Thread.new()
		threads.append(t)


# start the threads in the threads
func start_threads(image, chunk_size, y)->void:
	for x in threads.size():
		threads[x].start(
			self,
			"genrate_texture",
			[
				image,
				chunk_size,
				x, y
			]
		)


# join the threads in the threads
func join_thread()->void:
	while true:
		if (counter == threads.size()):
			var layers = []
			for t in threads:
				layers.append(t.wait_to_finish())
			array_of_texture.append(layers)
			counter = 0
			threads.clear()


# genereate texture
# WARNING : this function is only ment to be called through the `start_threads()`
func generate_texture(args:Array):
	# assigning value
	var image:Image        = args[0]
	var chunk_size:Vector2 = args[1]
	var index_x:int        = args[2]
	var index_y:int        = args[3]

	# genrate position
	var position = Vector2(
				chunk_size.x * index_x,
				chunk_size.y * index_y
			)

	# create new image form slice
	var new_image:Image = Image.new()
	new_image.create(chunk_size.x, chunk_size.y, true, image.get_format())
	new_image.blit_rect(image, Rect2(position, chunk_size), Vector2(0,0))
	
	# generate uuid and get save path
	var uuid = get_parent().uuid_util.v4()
	var save_location = get_parent().root_save_file_path + '/map_chunks/{uuid}_save_data.tres'.format({"uuid":uuid})

	# generate map fragment
	var image_fragment = MapFragment.new()
	image_fragment.create_from_image(new_image)
	image_fragment.chunk_position = position
	image_fragment.chunk_uuid     = uuid

	# save the map fragment
	var _z = ResourceSaver.save(save_location, image_fragment)

	# increase the counter
	mutex.lock()
	counter += 1
	mutex.unlock()

	return save_location