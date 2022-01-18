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

	assert_eq_deep(tile_set.get_tiles_ids(), [1, 2])
	assert_eq_deep(tile_set.tile_get_texture(1), y)
