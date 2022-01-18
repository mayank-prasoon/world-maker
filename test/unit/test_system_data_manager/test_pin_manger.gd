extends RootSystemTest

var test_pin_system_node:Node
var save_file_node:Node

func before_each():
	# instance of the gd script
	test_scene           = add_child_autoqfree(preload("res://singletone/SystemDataManager.tscn").instance())
	test_pin_system_node = test_scene.get_node("PinSystem").get_node("PinManager")
	save_file_node       = test_scene.get_node("PinSystem").get_node("SaveSystem")

func test_open_article():
	gut.p('Testing get method method')
	var uuid = test_scene.uuid_util.v4()
	
	var test_article_file:Resource = load("res://test/resources_and_temp_items/temp_test_article.tres")
	# delete file
	
	save_file_node.save_file(
			"temp_file_1",
			uuid,
			MapPin.new(),
			Vector2(0,0),
			test_article_file,
			true,
			Vector2(0,0),
			[]
	)

	# open files
	var _test_resource = test_pin_system_node.get_article(uuid)

	# assertion
	gut.p('\n=> \tTest Data\n')
	assert_eq(_test_resource,  test_article_file, "the name should be 'template_save_file'")
	assert_eq(_test_resource.article_name, "test_article123", "the name should be 'test_article123'")
	assert_eq(_test_resource.banner, "pqr", "the banner should be 'pqr'")
	assert_eq(_test_resource.raw_data, "xyz", "the raw data should be 'xyz'")
	assert_eq(_test_resource.tags.size(), 2, "the array size should be '2'")
	assert_eq_deep(_test_resource.tags, ["random", "568"])

#
#func test_get_chunk():
#	gut.p('Testing get chunk method')
#	var uuid = test_scene.uuid_util.v4()	
#
#	var test_chunk_file:Resource = load("res://test/resources_and_temp_items/temp_test_map_chunk.tres")
#	# delete file
#
#	save_file_node.save_file(
#			"temp_file_3",
#			uuid,
#			MapPin.new(),
#			Vector2(0,0),
#			RootArticle.new(),
#			true,
#			test_chunk_file,
#			[]
#	)
#
#	var _test_resource = test_pin_system_node.get_chunk(uuid)
#
#	assert_eq(_test_resource, test_chunk_file, "the name should be 'test_chunk_file'")
#	assert_eq(_test_resource.chunk_name, "temp_chunk", "the name should be 'temp_file_3'")
#	assert_eq(_test_resource.chunk_texture, "xyz", "the texture should be 'xyz'")
#	assert_eq(_test_resource.chunk_offset, Vector2(10,20), "the raw data should be 'Vector(10,20)'")
#	assert_eq(_test_resource.chunk_pins.size(), 2, "the array size should be '2'")


func test_get_template():
	gut.p('Testing get chunk method')
	var uuid = test_scene.uuid_util.v4()
	
	var test_map_symbol_template:Resource = load("res://test/resources_and_temp_items/test_map_symbol_template.tres")
	# delete file
	
	save_file_node.save_file(
			"temp_file_3",
			uuid,
			test_map_symbol_template,
			Vector2(0,0),
			RootArticle.new(),
			true,
			Vector2(0,0),
			[]
	)

	var _test_resource = test_pin_system_node.get_template(uuid)
	
	assert_eq(_test_resource, test_map_symbol_template, "the name should be 'test_map_symbol_template'")
	assert_eq(_test_resource.template_name, "test_template_symbol", "the name should be 'test_template_symbol'")
	assert_eq(_test_resource.template_texture, "xyz", "the texture should be 'xyz'")
	assert_eq(_test_resource.template_offset, Vector2(500,-20), "the raw data should be 'Vector(10,20)'")
	assert_eq(_test_resource.template_color, Color.black, "the color should be 'black'")

func test_get_tags():
	gut.p('Testing get tags method')
	var uuid = test_scene.uuid_util.v4()

	var test_array = ["books", "cooking", "house", "mouse", "cave"]

	save_file_node.save_file(
			"temp_file_3",
			uuid,
			MapSymbolTemplate.new(),
			Vector2(0,0),
			RootArticle.new(),
			true,
			Vector2(0,0),
			test_array
	)

	var _test_resource = test_pin_system_node.get_tags(uuid)

	assert_eq_deep(_test_resource, test_array)
