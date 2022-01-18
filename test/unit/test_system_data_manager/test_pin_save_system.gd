extends RootSystemTest

var _temp_resource       = preload("res://test/resources_and_temp_items/temp_test_resource.tres")
var test_pin_system_node:Node
# === BEFORE ===

func before_each():
	# instance of the gd script
	test_scene           = add_child_autoqfree(preload("res://singletone/SystemDataManager.tscn").instance())
	test_pin_system_node = test_scene.get_node("PinSystem").get_node("SaveSystem")

# === TESTS === 

# test the save file method 
func test_create_save_files():
	var uuid = test_scene.uuid_util.v4()
	var pin_save_file:String = "res://save_files/pins/{uid}_save_data.tres".format({"uid" : uuid})
	

	gut.p('=> \tTestting save file method')
	test_pin_system_node.save_file(
			"temp_pin_name",
			uuid,
			_temp_resource,
			Vector2(0,0),
			_temp_resource,
			true,
			Vector2(0,0),
			["books", "house"]
	)
	
	# assertion
	assert_file_exists(pin_save_file)

# test open the save file
func test_file_open():
	gut.p('Testting open file method')
	var uuid = test_scene.uuid_util.v4()
	
	test_pin_system_node.save_file(
		"fake_name",
		uuid,
		_temp_resource,
		Vector2(20,-100),
		_temp_resource,
		false,
		Vector2(10,20),
		["books", "house"]
	)

	# open files
	var _test_resource = test_pin_system_node.open_file(uuid)

	# assertion
	gut.p('\n=> \tTest Data\n')
	assert_eq(_test_resource.pin_name, "fake_name", "the pin name should be 'fake_name'") 
	assert_eq(_test_resource.pin_id, uuid, "the pin location should be `{id}'".format({"id": uuid}))
	assert_eq(_test_resource.pin_location, Vector2(20,-100), "the pin location should be `Vector2(20, -100)")
	assert_false(_test_resource.map_link_state, "the map_state_link should be false")
	assert_eq_deep(_test_resource.tags, ["books", "house"])

	gut.p('\n=> \tTest Resource File\n')
	assert_eq(_test_resource.pin_symbol_template, _temp_resource, "the resource file sould be same as _temp_resource")
	assert_eq(_test_resource.pin_article, _temp_resource, "the resource file sould be same as _temp_resource")
	assert_eq(_test_resource.linked_chunk, Vector2(10,20), "the resource file sould be same as _temp_resource")

# test verify files
func test_file_verification_recreation():
	var uuid = test_scene.uuid_util.v4()
	var xyz_save_file:String = "res://save_files/pins/{id}_save_data.tres".format({"id":uuid})
	
	gut.p('=> \tTestting file verification method')
	test_scene.verify(xyz_save_file, test_scene.MAP_RESOURCE_TYPE.PIN, uuid)
	
	# assertion
	assert_file_exists(xyz_save_file)
	
	# open files
	var _test_resource = test_pin_system_node.open_file(uuid)

	# assertion
	gut.p('\n=> \tTest Data\n')
	assert_eq(_test_resource.pin_name, "", "the pin name should be ''") 
	assert_eq(_test_resource.pin_id, uuid, "the pin location should be `{id}'".format({"id": uuid}))	
	assert_eq(_test_resource.pin_location, Vector2(0, 0), "the pin location should be `Vector2(0,0)")
	assert_false(_test_resource.map_link_state, "the map_state_link should be false")
	assert_eq_deep(_test_resource.tags, [])


# test remove all file
func test_remove_save_file():
	gut.p('=> \tTestting delete all file')
	
	var uuid_x = test_scene.uuid_util.v4()
	var uuid_y = test_scene.uuid_util.v4()
	var uuid_z = test_scene.uuid_util.v4()

	# create file
	var _x = ResourceSaver.save("res://save_files/pins/{x_id}_save_data.tres".format({"x_id":uuid_x}), MapPin.new())
	var _y = ResourceSaver.save("res://save_files/pins/{y_id}_save_data.tres".format({"y_id":uuid_y}), MapPin.new())
	var _z = ResourceSaver.save("res://save_files/pins/{z_id}_save_data.tres".format({"z_id":uuid_z}), MapPin.new())
	
	test_pin_system_node.remove_all_files()
	
	# assertion
	assert_file_does_not_exist("res://save_files/pins/{x_id}_save_data.tres".format({"x_id":uuid_x}))
	assert_file_does_not_exist("res://save_files/pins/{y_id}_save_data.tres".format({"y_id":uuid_y}))
	assert_file_does_not_exist("res://save_files/pins/{z_id}_save_data.tres".format({"z_id":uuid_z}))

# test remove a file
func test_remove_specific_save_file():
	gut.p('=> \tTestting delete sepecific file')
	var uuid = test_scene.uuid_util.v4()
	
	# creates file
	var _x = ResourceSaver.save("res://save_files/pins/{id}_save_data.tres".format({"id": uuid}), MapPin.new())

	test_pin_system_node.remove_file(uuid)

	# assertion
	assert_file_does_not_exist("res://save_files/pins/{id}_save_data.tres".format({"id": uuid}))
