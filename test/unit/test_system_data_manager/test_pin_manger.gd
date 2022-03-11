extends RootSystemTest

func test_open_article():
	gut.p('Testing get method method')
	var uuid = UUID.generate()
	
	var test_article_file:Resource = load("res://test/resources_and_temp_items/temp_test_article.tres")
	# delete file
	
	ResourceManager.save_file(
		{
			'pin_name'            : "temp_file_1",
			'pin_id'              : uuid,
			'pin_symbol_template' : MapSymbolTemplate.new(),
			'pin_location'        : Vector2(0,0),
			'pin_article'         : test_article_file,
			'map_link_state'      : true,
			'linked_chunk'        : Vector2(0,0),
			'tags'                : []
		},

		ResourceManager.PIN
	)

	yield(get_tree().create_timer(0.5), "timeout")

	# open files
	var _test_resource = PinManager.get_article(uuid)

	# assertion
	gut.p('\n=> \tTest Data\n')
	assert_eq(_test_resource,  test_article_file, "the name should be 'template_save_file'")
	assert_eq(_test_resource.article_name, "test_article123", "the name should be 'test_article123'")
	assert_eq(_test_resource.article_banner, "", "the banner should be 'pqr'")
	assert_eq(_test_resource.article_raw, "", "the raw data should be 'xyz'")
	assert_eq(_test_resource.tags.size(), 2, "the array size should be '2'")
	assert_eq_deep(_test_resource.tags, ["random", "568"])

#
#func test_get_chunk():
#	gut.p('Testing get chunk method')
#	var uuid = UUID.generate()	
#
#	var test_chunk_file:Resource = load("res://test/resources_and_temp_items/temp_test_map_chunk.tres")
#	# delete file
#
#	save_file_node.save_file(
#			"temp_file_3",
#			uuid,
#			MapPin.new(),
#			Vector2(0,0),
#			Article.new(),
#			true,
#			test_chunk_file,
#			[]
#	)
#
#	var _test_resource = PinManager.get_chunk(uuid)
#
#	assert_eq(_test_resource, test_chunk_file, "the name should be 'test_chunk_file'")
#	assert_eq(_test_resource.chunk_name, "temp_chunk", "the name should be 'temp_file_3'")
#	assert_eq(_test_resource.chunk_texture, "xyz", "the texture should be 'xyz'")
#	assert_eq(_test_resource.chunk_offset, Vector2(10,20), "the raw data should be 'Vector(10,20)'")
#	assert_eq(_test_resource.chunk_pins.size(), 2, "the array size should be '2'")


func test_get_template():
	gut.p('Testing get chunk method')
	var uuid = UUID.generate()
	
	var test_map_symbol_template:Resource = load("res://test/resources_and_temp_items/test_map_symbol_template.tres")
	# delete file
	
	ResourceManager.save_file(
		{
			'pin_name'            : "temp_file_3",
			'pin_id'              : uuid,
			'pin_symbol_template' : test_map_symbol_template,
			'pin_location'        : Vector2(0,0),
			'pin_article'         : Article.new(),
			'map_link_state'      : true,
			'linked_chunk'        : Vector2(0,0),
			'tags'                : []
		},

		ResourceManager.PIN
	)

	yield(get_tree().create_timer(0.5), "timeout")

	var _test_resource = PinManager.get_template(uuid)
	
	assert_eq(_test_resource, test_map_symbol_template, "the name should be 'test_map_symbol_template'")
	assert_eq(_test_resource.template_name, "test_template_symbol", "the name should be 'test_template_symbol'")
	assert_eq(_test_resource.template_texture, "xyz", "the texture should be 'xyz'")
	assert_eq(_test_resource.template_offset, Vector2(500,-20), "the raw data should be 'Vector(10,20)'")
	assert_eq(_test_resource.template_color, Color.black, "the color should be 'black'")

func test_get_tags():
	gut.p('Testing get tags method')
	var uuid = UUID.generate()

	var test_array = ["books", "cooking", "house", "mouse", "cave"]

	ResourceManager.save_file(
		{
			'pin_name'            : "temp_file_3",
			'pin_id'              : uuid,
			'pin_symbol_template' : MapSymbolTemplate.new(),
			'pin_location'        : Vector2(0,0),
			'pin_article'         : Article.new(),
			'map_link_state'      : true,
			'linked_chunk'        : Vector2(0,0),
			'tags'                : test_array
		},

		ResourceManager.PIN
	)

	yield(get_tree().create_timer(0.5), "timeout")

	var _test_resource = PinManager.get_tags(uuid)

	assert_eq_deep(_test_resource, test_array)
