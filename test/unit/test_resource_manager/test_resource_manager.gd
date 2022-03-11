extends RootSystemTest

func test_save_file():
	ResourceManager.save_file(
		{
			'map_name'     : "temp_file_1",
			'map_chunks'   : [],
			'chunk_size'   : Vector2(0,0),
			'chunk_number' :  0,
			'map_pins'     : [ ],
			'tags'         : [
					"random",
					"568"
				]
		},

		ResourceManager.MAP
	)
	
	yield(get_tree().create_timer(0.5), "timeout")
	
	assert_file_exists(ResourceManager.resource_path(ResourceManager.MAP).format({"uuid" : "temp_file_1"}))

func test_open_file():
	ResourceManager.save_file(
		{
			'map_name'     : "temp_file_1",
			'map_chunks'   : [],
			'chunk_size'   : Vector2(0,0),
			'chunk_number' :  0,
			'map_pins'     : [ ],
			'tags'         : [
					"random",
					"568"
				]
		},

		ResourceManager.MAP
	)

	yield(get_tree().create_timer(0.5), "timeout")

	var map:MapData =  ResourceManager.open_file("temp_file_1", ResourceManager.MAP)

	assert_eq(map.map_name, "temp_file_1")
	assert_eq(map.chunk_size, Vector2(0,0))
	assert_eq(map.chunk_number, 0)

	assert_eq_deep(map.map_pins, [])
	assert_eq_deep(map.tags, ["random","568"])
	assert_eq_deep(map.map_chunks, [])

func test_remove_all_map_files():
	gut.p('=> \tTestting delete all file')

	# create file
	var _x = ResourceSaver.save("res://save_files/maps/{x_id}_save_data.tres".format({"x_id":"xyz_1"}), MapData.new())
	var _y = ResourceSaver.save("res://save_files/maps/{y_id}_save_data.tres".format({"y_id":"xyz_2"}), MapData.new())
	var _z = ResourceSaver.save("res://save_files/maps/{z_id}_save_data.tres".format({"z_id":"xyz_1"}), MapData.new())
	
	ResourceManager.remove_all_files(ResourceManager.MAP)
	
	# assertion
	assert_file_does_not_exist("res://save_files/maps/{x_id}_save_data.tres".format({"x_id":"xyz_1"}))
	assert_file_does_not_exist("res://save_files/maps/{y_id}_save_data.tres".format({"y_id":"xyz_2"}))
	assert_file_does_not_exist("res://save_files/maps/{z_id}_save_data.tres".format({"z_id":"xyz_3"}))

func test_rmove_all_pin_files():
	gut.p('=> \tTestting delete all file')
	
	var uuid_x = UUID.generate()
	var uuid_y = UUID.generate()
	var uuid_z = UUID.generate()

	# create file
	var _x = ResourceSaver.save("res://save_files/pins/{x_id}_save_data.tres".format({"x_id":uuid_x}), MapPin.new())
	var _y = ResourceSaver.save("res://save_files/pins/{y_id}_save_data.tres".format({"y_id":uuid_y}), MapPin.new())
	var _z = ResourceSaver.save("res://save_files/pins/{z_id}_save_data.tres".format({"z_id":uuid_z}), MapPin.new())
	
	ResourceManager.remove_all_files(ResourceManager.PIN)
	
	# assertion
	assert_file_does_not_exist("res://save_files/pins/{x_id}_save_data.tres".format({"x_id":uuid_x}))
	assert_file_does_not_exist("res://save_files/pins/{y_id}_save_data.tres".format({"y_id":uuid_y}))
	assert_file_does_not_exist("res://save_files/pins/{z_id}_save_data.tres".format({"z_id":uuid_z}))

func test_remove_specific_save_file():
	gut.p('=> \tTestting delete sepecific file')
	
	# creates file
	var _x = ResourceSaver.save("res://save_files/maps/{id}_save_data.tres".format({"id": "pqr"}), MapData.new())

	ResourceManager.remove_file("pqr", ResourceManager.MAP)

	# assertion
	assert_file_does_not_exist("res://save_files/maps/{id}_save_data.tres".format({"id": "pqr"}))
