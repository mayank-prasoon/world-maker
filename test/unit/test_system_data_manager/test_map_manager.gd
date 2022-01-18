extends RootSystemTest

var test_pin_system_node:Node
var save_file_node:Node

func before_each():
	# instance of the gd script
	test_scene           = add_child_autoqfree(preload("res://singletone/SystemDataManager.tscn").instance())
	test_pin_system_node = test_scene.get_node("MapSystem").get_node("MapManager")
	save_file_node       = test_scene.get_node("MapSystem").get_node("SaveSystem")

func test_get_tags():
	gut.p('Testing get method method')
	
	save_file_node.save_file(
			"temp_file_1",
			TileSet.new(),
			Vector2(0,0),
			0,
			[ ],
			[
				"random",
				"568"
			]
	)
	
	yield(get_tree().create_timer(1.0), "timeout")
	
	# open files
	var _test_resource = test_pin_system_node.get_tags("temp_file_1")

	# assertion
	gut.p('\n=> \tTest Data\n')
	assert_eq(_test_resource.size(), 2, "the tags should be '2'")
	assert_eq_deep(_test_resource,   ["random", "568"])


func test_get_all_pins():
	gut.p('Testing get all pin method')

	var test_pin_save_file:Resource = load("res://test/resources_and_temp_items/temp_test_pin.tres")
	# delete file

	save_file_node.save_file(
		"temp_chunk_5",
		TileSet.new(),
		Vector2(65, 25),
		0,
		[
			test_pin_save_file,
			test_pin_save_file,
			test_pin_save_file
		],
		[]
	)
	
	yield(get_tree().create_timer(1.0), "timeout")
	
	# open files
	var _test_resource = test_pin_system_node.get_all_pins("temp_chunk_5")

	# assertion
	gut.p('\n=> \tTest Data\n')
	assert_eq_deep(_test_resource,  [test_pin_save_file, test_pin_save_file, test_pin_save_file])
	assert_eq(_test_resource.size(), 3, "the size should be '3'")
	assert_eq(_test_resource[0].pin_name, "book", "the name should be 'test_article123'")
	assert_eq(_test_resource[0].pin_location, Vector2(500, 200), "the location should be 'vector(500, 200)'")
	assert_eq(_test_resource[0].map_link_state, false, "the state should be 'false'")

	# pending("map_chunk_manager is currently under devlopment")

func test_get_specific_pin():
	gut.p('Testing get specific pin method')
	
	var uuid = test_scene.uuid_util.v4()
	var test_pin_save_file:Resource = load("res://test/resources_and_temp_items/temp_test_pin.tres")
	# delete file

	save_file_node.save_file(
		"temp_chunk_5",
		TileSet.new(),
		Vector2(65, 25),
		0,
		[
			test_pin_save_file,
			test_pin_save_file,
			test_pin_save_file
		],
		[]
	)
	
	yield(get_tree().create_timer(1.0), "timeout")
	
	# open files
	var _test_resource = test_pin_system_node.get_pins_by_name("temp_chunk_5", "book")

	# assertion
	gut.p('\n=> \tTest Data\n')
	assert_eq_deep(_test_resource,  [test_pin_save_file, test_pin_save_file, test_pin_save_file])
	assert_eq(_test_resource.size(), 3, "the size should be '3'")
	assert_eq(_test_resource[0].pin_name, "book", "the name should be 'test_article123'")
	assert_eq(_test_resource[0].pin_location, Vector2(500, 200), "the location should be 'vector(500, 200)'")
	assert_eq(_test_resource[0].map_link_state, false, "the state should be 'false'")

func test_get_pin_by_name():
	gut.p('Testing get pin by name method')
	
	var test_pin_save_file_1:Resource = load("res://test/resources_and_temp_items/test_pins/temp_test_pin_1.tres")
	var test_pin_save_file_2:Resource = load("res://test/resources_and_temp_items/test_pins/temp_test_pin_2.tres")
	var test_pin_save_file_3:Resource = load("res://test/resources_and_temp_items/test_pins/temp_test_pin_3.tres")
	var test_pin_save_file_4:Resource = load("res://test/resources_and_temp_items/test_pins/temp_test_pin_6.tres")
	# delete file

	save_file_node.save_file(
		"temp_chunk_5",
		TileSet.new(),
		Vector2(65, 25),
		0,
		[
			test_pin_save_file_1,
			test_pin_save_file_2,
			test_pin_save_file_3,
			test_pin_save_file_4
		],
		[]
	)
	
	yield(get_tree().create_timer(1.0), "timeout")
	
	# open files
	var _test_resource_1 = test_pin_system_node.get_pins_by_name("temp_chunk_5", "book")
	var _test_resource_2 = test_pin_system_node.get_pins_by_name("temp_chunk_5", "book_7")

	# assertion
	gut.p('\n=> \tTest Data\n')
	assert_eq_deep(_test_resource_1, [test_pin_save_file_1, test_pin_save_file_2, test_pin_save_file_3, test_pin_save_file_4])
	assert_eq(_test_resource_1.size(), 4, "the size should be '4'")

	assert_eq_deep(_test_resource_2, [test_pin_save_file_4])
	assert_eq(_test_resource_2.size(), 1, "the size should be '1'")
	assert_eq(_test_resource_2[0].pin_name, 'book_7', "the name should be 'book_7'")

# test if the method retruns the last pin
func test_get_last_pin():
	gut.p('Testing get last pin method')

	var uuid = test_scene.uuid_util.v4()
	
	var test_pin_save_file_1:Resource = load("res://test/resources_and_temp_items/test_pins/temp_test_pin_1.tres")
	var test_pin_save_file_2:Resource = load("res://test/resources_and_temp_items/test_pins/temp_test_pin_2.tres")
	var test_pin_save_file_3:Resource = load("res://test/resources_and_temp_items/test_pins/temp_test_pin_3.tres")
	var test_pin_save_file_4:Resource = load("res://test/resources_and_temp_items/test_pins/temp_test_pin_6.tres")
	# delete file

	save_file_node.save_file(
		"temp_chunk_5",
		TileSet.new(),
		Vector2(65, 25),
		0,
		[
			test_pin_save_file_1,
			test_pin_save_file_2,
			test_pin_save_file_3,
			test_pin_save_file_4
		],
		[]
	)

	yield(get_tree().create_timer(1.0), "timeout")


	# open files
	var _test_resource = test_pin_system_node.get_last_pin("temp_chunk_5")

	# assertion
	gut.p('\n=> \tTest Data\n')
	assert_eq(_test_resource, test_pin_save_file_4, "the map pin should be 'test_pin_save_file_4'")


# test if the method retruns the first pin
func test_get_first_pin():
	gut.p('Testing get first pin method')

	var test_pin_save_file_1:Resource = load("res://test/resources_and_temp_items/test_pins/temp_test_pin_1.tres")
	var test_pin_save_file_2:Resource = load("res://test/resources_and_temp_items/test_pins/temp_test_pin_2.tres")
	var test_pin_save_file_3:Resource = load("res://test/resources_and_temp_items/test_pins/temp_test_pin_3.tres")
	var test_pin_save_file_4:Resource = load("res://test/resources_and_temp_items/test_pins/temp_test_pin_6.tres")
	# delete file

	save_file_node.save_file(
		"temp_chunk_5",
		TileSet.new(),
		Vector2(65, 25),
		0,
		[
			test_pin_save_file_1,
			test_pin_save_file_2,
			test_pin_save_file_3,
			test_pin_save_file_4
		],
		[]
	)
	
	yield(get_tree().create_timer(1.0), "timeout")
	
	# open files
	var _test_resource = test_pin_system_node.get_first_pin("temp_chunk_5")
	
	# assertion
	gut.p('\n=> \tTest Data\n')
	assert_eq(_test_resource, test_pin_save_file_1, "the map pin should be 'test_pin_save_file_1'")
