extends RootSystemTest

var test_map_chunk_system_node:Node

# === BEFORE ===

func before_each():
	# instance of the gd script
	test_scene = add_child_autoqfree(load("res://singletone/SaveSystem.tscn").instance())
	test_map_chunk_system_node = test_scene.get_child(2).get_child(0)

# === TESTS === 

# test the save file method 
func test_create_save_files():
	var uuid = test_scene.uuid_util.v4()
	var map_chunk_save_file:String = "res://save_files/map_chunks/{uid}_save_data.tres".format({"uid" : uuid})

	
	gut.p('=> \tTestting save file method')
	test_map_chunk_system_node.save_file("temp_map_chunk_name", uuid, "xyz", Vector2(0,0), [_temp_resource, _temp_resource, _temp_resource])
	
	# assertion
	assert_file_exists(map_chunk_save_file)

# test open the save file
func test_file_open():
	var uuid = test_scene.uuid_util.v4()

	gut.p('Testting open file method')

	test_map_chunk_system_node.save_file("fake_name", uuid, "pqr", Vector2(5,10), [_temp_resource, _temp_resource])

	# open files
	var _test_resource = test_map_chunk_system_node.open_file(uuid)

	# assertion
	gut.p('\n=> \tTest Data\n')
	assert_eq(_test_resource.chunk_name, "fake_name", "the pin name should be 'fake_name'") 
	assert_eq(_test_resource.chunk_id, uuid, "the pin name should be '{uid}'".format({"uid" : uuid}))
	assert_eq(_test_resource.chunk_offset, Vector2(5,10), "the pin location should be `Vector2(5,10)")
	assert_eq(_test_resource.chunk_texture, "pqr", "the path name sould be 'pqr")
	assert_eq(_test_resource.chunk_pins.size(), 2, "the number of pin should be 2")
	assert_eq_deep(_test_resource.chunk_pins, [_temp_resource, _temp_resource])


# test verify files
func test_file_verification_recreation():
	var uuid = test_scene.uuid_util.v4()
	var xyz_save_file:String = "res://save_files/map_chunks/{uid}_save_data.tres".format({"uid" : uuid})

	# remove files
	
	gut.p('=> \tTestting file verification method')
	test_scene.verify(xyz_save_file, test_scene.MAP_RESOURCE_TYPE.MAP_CHUNK, uuid)
	
	# assertion
	assert_file_exists(xyz_save_file)

	# open files
	var _test_resource = test_map_chunk_system_node.open_file(uuid)

	# assertion
	gut.p('\n=> \tTest Data\n')
	assert_eq(_test_resource.chunk_name, "", "the pin name should be 'fake_name'")
	assert_eq(_test_resource.chunk_id, uuid, "the pin name should be '{uid}'".format({"uid" : uuid}))
	assert_eq(_test_resource.chunk_offset, Vector2(0,0), "the pin location should be `Vector2(0,0)")
	assert_eq(_test_resource.chunk_texture, "xyz", "the path name sould be 'xyz")
	assert_eq(_test_resource.chunk_pins.size(), 0, "the number of pin should be 0")
	assert_eq_deep(_test_resource.chunk_pins, [])
	
	
# test remove all file
func test_remove_save_file():
	gut.p('=> \tTestting delete all file')

	var uuid_x = test_scene.uuid_util.v4()
	var uuid_y = test_scene.uuid_util.v4()
	var uuid_z = test_scene.uuid_util.v4()
	
	# create file
	var _x = ResourceSaver.save("res://save_files/map_chunks/{uid}_save_data.tres".format({"uid" : uuid_x}), MapChunkData.new())
	var _y = ResourceSaver.save("res://save_files/map_chunks/{uid}_save_data.tres".format({"uid" : uuid_y}), MapChunkData.new())
	var _z = ResourceSaver.save("res://save_files/map_chunks/{uid}_save_data.tres".format({"uid" : uuid_z}), MapChunkData.new())
	
	test_map_chunk_system_node.remove_all_files()
	
	# assertion
	assert_file_does_not_exist("res://save_files/map_chunks/{uid}_save_data.tres".format({"uid" : uuid_x}))
	assert_file_does_not_exist("res://save_files/map_chunks/{uid}_save_data.tres".format({"uid" : uuid_y}))
	assert_file_does_not_exist("res://save_files/map_chunks/{uid}_save_data.tres".format({"uid" : uuid_z}))

# test remove a file
func test_remove_specific_save_file():
	gut.p('=> \tTestting delete sepecific file')
	var uuid = test_scene.uuid_util.v4()
	
	# creates file
	var _x = ResourceSaver.save("res://save_files/map_chunks/{uid}_save_data.tres".format({"uid" : uuid}), MapChunkData.new())

	test_map_chunk_system_node.remove_file(uuid)

	# assertion
	assert_file_does_not_exist("res://save_files/map_chunks/{uid}_save_data.tres".format({"uid" : uuid}))
