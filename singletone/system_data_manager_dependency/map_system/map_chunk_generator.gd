extends Node

onready var root_node      = get_parent().get_parent()

# slices image into small textures
func slice_texture(texture_path:String, chunk_size:Vector2 = Vector2(512, 288))->Array:
	var image:Image           = load_image(texture_path)
	var image_size:Vector2    = image.get_size()

	var chunk_count:float     = Rect2(Vector2(0,0), image_size).get_area() / Rect2(Vector2(0,0), chunk_size).get_area()
	var chunk_dimension:float = sqrt(chunk_count)

	var texture_array:Array   = []
	for current_layer in range(chunk_dimension):
		var layers = []
		for x in range(chunk_dimension):
			layers.append(generate_texture([image.duplicate(), chunk_size, x, current_layer]))
		texture_array.append(layers)

	return texture_array

# load image
func load_image(image_path:String)->Image:
	var new_image = Image.new()
	new_image.load(image_path)
	
	return new_image

# genereate and save map fragments
# WARNING : this is only ment to be called through the `start_threads()`
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
	var uuid = root_node.uuid_util.v4()
	var save_location = root_node.root_save_file_path + '/map_chunks/{uuid}_save_data.tres'.format({"uuid":uuid})

	# generate map fragment
	var image_fragment = MapFragment.new()
	image_fragment.create_from_image(new_image)
	image_fragment.chunk_position = position
	image_fragment.chunk_uuid     = uuid

	# save the map fragment
	var _z = ResourceSaver.save(save_location, image_fragment)
	return save_location

