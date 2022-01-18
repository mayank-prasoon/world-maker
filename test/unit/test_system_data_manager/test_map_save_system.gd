extends RootSystemTest

var _temp_resource       = preload("res://test/resources_and_temp_items/temp_test_resource.tres")
var test_pin_system_node:Node
# === BEFORE ===

func before_each():
	# instance of the gd script
	test_scene           = add_child_autoqfree(preload("res://singletone/SystemDataManager.tscn").instance())
	test_pin_system_node = test_scene.get_node("MapSystem").get_node("SaveSystem")

# === TESTS === 

# test the save file method 
func test_create_save_files():
	var pin_save_file:String = "res://save_files/maps/{uid}_save_data.tres".format({"uid" : "temp_map_name"})
	
	gut.p('=> \tTestting save file method')
	test_pin_system_node.save_file(
			"temp_map_name",
			TileSet.new(),
			Vector2(20, 10),
			10,
			[_temp_resource, _temp_resource, _temp_resource],
			["books", "house"]
	)

	yield(get_tree().create_timer(1.0), "timeout")
	
	# assertion
	assert_file_exists(pin_save_file)

# test open the save file
func test_file_open():
	gut.p('Testting open file method')
	
	test_pin_system_node.save_file(
		"fake_name",
		TileSet.new(),
		Vector2(20, 10),
		10,
		[_temp_resource, _temp_resource, _temp_resource],
		["books", "house"]
	)

	yield(get_tree().create_timer(1.0), "timeout")
	
	# open files
	var _test_resource = test_pin_system_node.open_file("fake_name")

	# assertion
	gut.p('\n=> \tTest Data\n')
	assert_eq(_test_resource.map_name, "fake_name", "the pin name should be 'fake_name'") 
	assert_eq(_test_resource.chunk_size, Vector2(20, 10))
	assert_eq(_test_resource.chunk_number, 10)
	assert_eq_deep(_test_resource.map_pins, [_temp_resource, _temp_resource, _temp_resource])
	assert_eq_deep(_test_resource.tags, ["books", "house"])


# test verify files
func test_file_verification_recreation():
	var xyz_save_file:String = "res://save_files/maps/{id}_save_data.tres".format({"id":"xyz"})
	
	gut.p('=> \tTestting file verification method')
	test_scene.verify(xyz_save_file, test_scene.MAP_RESOURCE_TYPE.MAP, "xyz")
	
	yield(get_tree().create_timer(1.0), "timeout")
	
	# assertion
	assert_file_exists(xyz_save_file)
	
	# open files
	var _test_resource = test_pin_system_node.open_file("xyz")
	
	# assertion
	gut.p('\n=> \tTest Data\n')
	assert_eq(_test_resource.map_name, "xyz", "the pin name should be ''") 
	assert_eq(_test_resource.chunk_size, Vector2(0,0))
	assert_eq(_test_resource.chunk_number, 0)
	assert_eq_deep(_test_resource.map_pins, [])
	assert_eq_deep(_test_resource.tags, [])


# test remove all file
func test_remove_save_file():
	gut.p('=> \tTestting delete all file')

	# create file
	var _x = ResourceSaver.save("res://save_files/maps/{x_id}_save_data.tres".format({"x_id":"xyz_1"}), MapData.new())
	var _y = ResourceSaver.save("res://save_files/maps/{y_id}_save_data.tres".format({"y_id":"xyz_2"}), MapData.new())
	var _z = ResourceSaver.save("res://save_files/maps/{z_id}_save_data.tres".format({"z_id":"xyz_1"}), MapData.new())
	
	test_pin_system_node.remove_all_files()
	
	# assertion
	assert_file_does_not_exist("res://save_files/maps/{x_id}_save_data.tres".format({"x_id":"xyz_1"}))
	assert_file_does_not_exist("res://save_files/maps/{y_id}_save_data.tres".format({"y_id":"xyz_2"}))
	assert_file_does_not_exist("res://save_files/maps/{z_id}_save_data.tres".format({"z_id":"xyz_3"}))

# test remove a file
func test_remove_specific_save_file():
	gut.p('=> \tTestting delete sepecific file')
	
	# creates file
	var _x = ResourceSaver.save("res://save_files/maps/{id}_save_data.tres".format({"id": "pqr"}), MapData.new())

	test_pin_system_node.remove_file("pqr")

	# assertion
	assert_file_does_not_exist("res://save_files/maps/{id}_save_data.tres".format({"id": "pqr"}))
