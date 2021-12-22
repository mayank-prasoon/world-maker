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
			[ ],
			[
				"random",
				"568"
			]
	)

	# open files
	var _test_resource = test_pin_system_node.get_tags("temp_file_1")

	# assertion
	gut.p('\n=> \tTest Data\n')
	assert_eq(_test_resource.size(), 2, "the name should be '2'")
	assert_eq_deep(_test_resource,   ["random", "568"])


func test_get_all_layers():
	gut.p('Testing get layers method')
	var test_chunk_file:Resource = load("res://test/resources_and_temp_items/temp_test_map_chunk.tres")
	# delete file
	
	var test_files = [
		[test_chunk_file, test_chunk_file],
		[test_chunk_file, test_chunk_file, test_chunk_file],
		[test_chunk_file, test_chunk_file, test_chunk_file, test_chunk_file, test_chunk_file]
	]

	save_file_node.save_file(
		"temp_file_2",
		test_files,
		[
			"random",
			"568"
		]
	)

	var _test_resource = test_pin_system_node.get_layers("temp_file_2")
	
	assert_eq_deep(_test_resource, test_files)
	assert_eq_deep(_test_resource[0], [test_chunk_file, test_chunk_file])
	
func test_get_last_layer():
	gut.p('Testing get last layer method')
	
	var test_chunk_file:Resource = load("res://test/resources_and_temp_items/temp_test_map_chunk.tres")
	# delete file
	
	var test_files = [
		[test_chunk_file, test_chunk_file],
		[test_chunk_file, test_chunk_file, test_chunk_file],
		[test_chunk_file, test_chunk_file, test_chunk_file, test_chunk_file, test_chunk_file]
	]

	save_file_node.save_file(
		"temp_file_3",
		test_files,
		[
			"random",
			"568"
		]
	)
	
	var _test_resource = test_pin_system_node.get_last_layer("temp_file_3")
	
	assert_eq_deep(_test_resource, [test_chunk_file, test_chunk_file, test_chunk_file, test_chunk_file, test_chunk_file])
	
	

func test_get_first_layer():
	gut.p('Testing get first layer method')
	
	var test_chunk_file:Resource = load("res://test/resources_and_temp_items/temp_test_map_chunk.tres")
	# delete file
	
	var test_files = [
		[test_chunk_file, test_chunk_file],
		[test_chunk_file, test_chunk_file, test_chunk_file],
		[test_chunk_file, test_chunk_file, test_chunk_file, test_chunk_file, test_chunk_file]
	]

	save_file_node.save_file(
		"temp_file_4",
		test_files,
		[
			"random",
			"568"
		]
	)
	
	var _test_resource = test_pin_system_node.get_first_layer("temp_file_4")
	
	assert_eq_deep(_test_resource, [test_chunk_file, test_chunk_file])

func test_get_layer():
	gut.p('Testing get spesific layer method')
	
	var test_chunk_file:Resource = load("res://test/resources_and_temp_items/temp_test_map_chunk.tres")
	# delete file
	
	var test_files = [
		[test_chunk_file, test_chunk_file],
		[test_chunk_file, test_chunk_file, test_chunk_file],
		[test_chunk_file, test_chunk_file, test_chunk_file, test_chunk_file, test_chunk_file]
	]

	save_file_node.save_file(
		"temp_file_5",
		test_files,
		[
			"random",
			"568"
		]
	)
	
	var _test_resource = test_pin_system_node.get_layer("temp_file_5", 1)
	
	assert_eq_deep(_test_resource, [test_chunk_file, test_chunk_file, test_chunk_file])
	
