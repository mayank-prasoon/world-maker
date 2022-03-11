extends Node

# === Threads and Mutex ===

var threads:Array = []
var mutex:Mutex   = Mutex.new()

# === Variables ===

var tile_generated:int     = 0
var tile_set:TileSet       = TileSet.new()
var tile_save_path:String  = ""
var chunk_count:int        = 0


# load the image
func load_image(image_path:String)->Image:
	var new_image:Image = Image.new()
	var _error:int = new_image.load(image_path)
	
	return new_image

# get the number of chunk
func get_chunk_count(image_size:Vector2, chunk_size:Vector2)->int:
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
func slice_texture(texture_path:String, chunk_size:Vector2 = Vector2(512, 288))->String:
	var image:Image           = load_image(texture_path)
	
	chunk_count               = get_chunk_count(image.get_size(), chunk_size)
	tile_set                  = TileSet.new()
	
	var image_dimension:float = sqrt(chunk_count)
	
	generate_map_chunks(
		[
			image_dimension,
			image,
			chunk_size,
			tile_set
		]
	)
	
	tile_save_path = self.get_owner().root_save_file_path + "/map_chunks/{uuid}_tile_save_data.tres".format({"uuid" : get_owner().uuid_util.v4()})

	return tile_save_path

# generate tile set and add images to tileset
# WARNING : this method is ment to be accessed via a thread
func generate_map_chunks(args:Array)->void:
	var image_dimension:int = args[0]
	var image:Image         = args[1]
	var chunk_size:Vector2  = args[2]
	var tile_set:TileSet    = args[3]
	
	for current_layer in range(image_dimension):
		for x in range(image_dimension):
			var t = Thread.new()
			threads.append(t)
			t.start(
				self,
				"generate_tile",
					[
						image,
						chunk_size,
						x,
						current_layer,
						image_dimension,
						tile_set
					]
				)


# generate tile
# NOTE: this method needs a rework
func generate_tile(arg):

	# == Note ==
	# args[0] is copy of the image
	# args[1] is size of the chunk
	# args[2] is the x coordinate of the tile
	# args[3] is the y coorfinate of the tile
	# args[4] is the dimension of the one side of the image where 1 unit = chunk size
	# args[5] is the tile set

	# lock the other threads
	mutex.lock()

	# generates textures
	var image_slice = load(generate_texture(arg[0], arg[1], arg[2], arg[3]))
	
	# assign those textures to tiles
	make_tile(arg[5], ((arg[4] * arg[3]) + arg[2]), image_slice)
	
	tile_generated += 1
	self.call_deferred("check_the_tally")
	
	# unlock all threads
	mutex.unlock()


# genereate and save map fragments
func generate_texture(image:Image, chunk_size:Vector2, index_x:int, index_y:int)->String:

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

	# generate image texture for tiles
	var image_fragment:ImageTexture = ImageTexture.new()
	image_fragment.create_from_image(new_image, ImageTexture.FLAG_MIPMAPS)

	# path to save the game data
	var save_path:String = self.get_owner().root_save_file_path + "/map_chunks/{uuid}_chunks.tres".format({"uuid" : get_owner().uuid_util.v4()})

	# save the image on the disk
	var _x = ResourceSaver.save(save_path, image_fragment)

	return save_path


# make tiles
func make_tile(tile_:TileSet, tile_counter:int, image_texture:ImageTexture)->void:
	tile_.create_tile(tile_counter)
	tile_.tile_set_texture(tile_counter, image_texture)


# joins the threads when exiting the scene
func _exit_tree():
	for x in threads:
		x.wait_to_finish()


# resives the signal when the map 
func _on_SaveSystem_data_saved():
	# increases the the tally by +1
	var loading_screen:Control = get_tree().get_nodes_in_group("loading_screen")[0]
	loading_screen.call_deferred("add_new_value", 1)

# increase the tally
func check_the_tally():
	# increases the the tally by +1
	var loading_screen:Control = get_tree().get_nodes_in_group("loading_screen")[0]
	loading_screen.add_new_value(1)

	if (tile_generated == chunk_count - 1):
		var _x = ResourceSaver.save(tile_save_path, tile_set)
		get_parent().save_map(tile_save_path, chunk_count)
