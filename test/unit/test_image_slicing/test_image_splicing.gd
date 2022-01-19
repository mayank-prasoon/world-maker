extends RootSystemTest

var test_map_generation:Node
var image_path:String         = "/home/mayank/Downloads/pexels-imad-clicks-10656139.jpg"

# === BEFORE ===

func before_each():
	# instance of the gd script
	test_scene           = add_child_autoqfree(preload("res://singletone/SystemDataManager.tscn").instance())
	test_map_generation  = test_scene.get_node("MapSystem/MapchunkGenerator")

# === TESTS === 
func test_get_chunk_count():
	var x = test_map_generation.load_image(image_path)
	var y = test_map_generation.get_chunk_count(x.get_size(), Vector2(512, 288))
	assert_eq(y, 225)

func test_generate_texture():
	var x = test_map_generation.load_image(image_path)
	var y:ImageTexture = test_map_generation.generate_texture(x, Vector2(512, 288), 0, 0)

	assert_eq_deep(y.get_size(), Vector2(512, 288))

func test_make_tile():

	var tile_set:TileSet = TileSet.new()

	var x = test_map_generation.load_image(image_path)
	var y:ImageTexture = test_map_generation.generate_texture(x, Vector2(512, 288), 0, 0)

	test_map_generation.make_tile(tile_set, 2, y)
	test_map_generation.make_tile(tile_set, 1, y)

	assert_eq(test_map_generation.tile_made, 0)
	assert_eq_deep(tile_set.get_tiles_ids(), [1, 2])
	assert_eq_deep(tile_set.tile_get_texture(1), y)

func test_generate_tile():
	var tile_set:TileSet = TileSet.new()

	var x = test_map_generation.load_image(image_path)

	test_map_generation.generate_tile(
		[
			x,
			Vector2(512, 288),
			2,
			2,
			15,
			tile_set
		]
	)
	
	test_map_generation.generate_tile(
		[
			x,
			Vector2(512, 288),
			3,
			1,
			15,
			tile_set
		]
	)
	
	assert_eq(test_map_generation.tile_made, 2)
	assert_eq_deep(tile_set.get_tiles_ids(), [(15*1)+3, 32])

func test_slice_texture():
	var x:TileSet = test_map_generation.slice_texture(image_path)

	yield(get_tree().create_timer(1.0), "timeout")

	assert_eq(x.get_tiles_ids().size(), 225)
	assert_eq(test_map_generation.tile_made, 225)
