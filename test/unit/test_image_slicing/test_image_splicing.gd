extends RootSystemTest

var image_path:String         = "/home/mayank/Downloads/pexels-imad-clicks-10656139.jpg"

# === TESTS === 
func test_get_chunk_count():
	var x = ImageHandler.load_image(image_path)
	var y = MapGen.get_chunk_count(x.get_size(), Vector2(512, 288))
	assert_eq(y, 225)

func test_make_texture():
	var x = ImageHandler.load_image(image_path)
	var y:String = MapGen.make_texture(x, Vector2(512, 288), 0, 0)
	
	yield(get_tree().create_timer(0.5), "timeout")

	var z = ImageHandler.load_image(y).get_size()
	assert_eq_deep(z, Vector2(512, 288))

#func test_slice_texture():
#	MapGen.generate_map('book', image_path)
#
#	yield(get_tree().create_timer(1.0), "timeout")
#
#	var test_map:MapData = ResourceManager.open_file(
#			'book',
#			ResourceManager.MAP
#		)
#	assert_eq(test_map.map_chunks[0].get_tiles_ids().size(), 225)
#	assert_eq(test_map.map_chunks, 225)
