extends RootSystemTest

var _temp_resource:Resource    = preload("res://test/resources_and_temp_items/temp_test_resource.tres")
var test_pin_system_node:Node
var save_system:Node

# === BEFORE ===

func before_each():
	# instance of the gd script
	test_scene           = add_child_autoqfree(preload("res://singletone/SystemDataManager.tscn").instance())
	test_pin_system_node = test_scene.get_node("PinSystem")
	save_system          = test_scene.get_node("PinSystem").get_node("SaveSystem")

func test_make_new_file():
	var uuid = test_pin_system_node.make_new_pin(
		"home",
		MapSymbolTemplate.new(),
		Vector2(20, 100),
		RootArticle.new(),
		true,
		MapChunkData.new(),
		[
			"home",
			"safe",
			"country side"
		]
	)

	# asserstions

	var _x = save_system.open_file(uuid)

	assert_file_exists("res://save_files/pins/{uid}_save_data.tres".format({"uid" : uuid}))
	assert_eq(_x.pin_name, "home")
	assert_eq(_x.pin_id, uuid)
	assert_eq(_x.pin_location, Vector2(20, 100))
	assert_eq_deep(_x.tags, ["home", "safe", "country side"])

func test_add_chunk():
	var uuid = test_pin_system_node.make_new_pin(
		"home",
		MapSymbolTemplate.new(),
		Vector2(20, 100),
		RootArticle.new(),
		false,
		MapChunkData.new(),
		[
			"home",
			"safe",
			"country side"
		]
	)

	# asserstions
	var chunk = preload("res://test/resources_and_temp_items/temp_test_map_chunk.tres")

	test_pin_system_node.add_chunk(uuid, chunk)
	var _x = save_system.open_file(uuid)

	assert_file_exists("res://save_files/pins/{uid}_save_data.tres".format({"uid" : uuid}))
	assert_eq(_x.pin_name, "home")
	assert_eq(_x.pin_id, uuid)
	assert_eq(_x.pin_location, Vector2(20, 100))

	assert_eq_deep(_x.linked_chunk, chunk)
	assert_eq(_x.linked_chunk.chunk_name, "temp_chunk")
	assert_eq(_x.linked_chunk.chunk_texture, "xyz")
	assert_eq(_x.linked_chunk.chunk_offset, Vector2(10, 20))
	assert_eq_deep(_x.tags, ["home", "safe", "country side"])

func test_add_artilce():
	var uuid = test_pin_system_node.make_new_pin(
		"home",
		MapSymbolTemplate.new(),
		Vector2(20, 100),
		RootArticle.new(),
		false,
		MapChunkData.new(),
		[
			"home",
			"safe",
			"country side"
		]
	)
	var article = preload("res://test/resources_and_temp_items/temp_test_article.tres")

	test_pin_system_node.add_article(uuid, article)
	var _x = save_system.open_file(uuid)

	assert_file_exists("res://save_files/pins/{uid}_save_data.tres".format({"uid" : uuid}))
	assert_eq(_x.pin_name, "home")
	assert_eq(_x.pin_id, uuid)
	assert_eq(_x.pin_location, Vector2(20, 100))
	assert_eq_deep(_x.pin_article, article)
	assert_eq_deep(_x.tags, ["home", "safe", "country side"])

func test_add_remove_tags():
	var uuid = test_pin_system_node.make_new_pin(
		"home",
		MapSymbolTemplate.new(),
		Vector2(20, 100),
		RootArticle.new(),
		false,
		MapChunkData.new(),
		[
			"home",
			"safe",
			"country side"
		]
	)

	var _y = save_system.open_file(uuid)
	assert_eq_deep(_y.tags, ["home", "safe", "country side"])

	test_pin_system_node.add_tags(uuid, ["book store", "city"])
	var _x = save_system.open_file(uuid)

	assert_file_exists("res://save_files/pins/{uid}_save_data.tres".format({"uid" : uuid}))
	assert_eq(_x.pin_name, "home")
	assert_eq(_x.pin_id, uuid)
	assert_eq(_x.pin_location, Vector2(20, 100))
	assert_eq_deep(_x.tags, ["home", "safe", "country side", "book store", "city"])

	test_pin_system_node.remove_tags(uuid, ["home", "safe", "country side"])
	var _z = save_system.open_file(uuid)
	assert_eq_deep(_z.tags, ["book store", "city"])
