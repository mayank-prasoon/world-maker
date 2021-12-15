extends RootSystemTest

var _temp_resource       = preload("res://test/resources_and_temp_items/temp_test_resource.tres")
var test_pin_system_node:Node
# === BEFORE ===

func before_each():
	# instance of the gd script
	test_scene           = add_child_autoqfree(preload("res://singletone/SystemDataManager.tscn").instance())
	test_pin_system_node = test_scene.get_node("SymbolTemplateSystem").get_node("SaveSystem")

# === TESTS === 

# test the save file method 
func test_create_save_files():
	var pin_save_file:String = "res://save_files/map_symbol_templates/{uid}_save_data.tres".format({"uid" : "temp_template_name"})
	

	gut.p('=> \tTestting save file method')
	test_pin_system_node.save_file(
			"temp_template_name",
			"xyz",
			Vector2(0,0),
			Color.pink
	)
	
	# assertion
	assert_file_exists(pin_save_file)

# test open the save file
func test_file_open():
	gut.p('Testting open file method')
	
	test_pin_system_node.save_file(
		"fake_name",
		"xyz",
		Vector2(20,-100),
		Color.pink
	)

	# open files
	var _test_resource = test_pin_system_node.open_file("fake_name")

	# assertion
	gut.p('\n=> \tTest Data\n')
	assert_eq(_test_resource.template_name, "fake_name", "the template name should be 'fake_name'") 
	assert_eq(_test_resource.template_texture, "xyz", "the template texture should be 'xyz'") 
	assert_eq(_test_resource.template_offset, Vector2(20,-100), "the template offset should be `Vector2(20, -100)")
	assert_eq(_test_resource.template_color, Color.pink, "the color should be 'pink'") 
	
# test verify files
func test_file_verification_recreation():
	var xyz_save_file:String = "res://save_files/map_symbol_templates/{id}_save_data.tres".format({"id":"xyz"})
	
	gut.p('=> \tTestting file verification method')
	test_scene.verify(xyz_save_file, test_scene.MAP_RESOURCE_TYPE.PIN_TEMPLATE, "xyz")
	
	# assertion
	assert_file_exists(xyz_save_file)
	
	# open files
	var _test_resource = test_pin_system_node.open_file("xyz")

	# assertion
	gut.p('\n=> \tTest Data\n')
	assert_eq(_test_resource.template_name, "xyz", "the template name should be 'xyz'") 
	assert_eq(_test_resource.template_offset, Vector2(0, 0), "the offset should be `Vector2(0,0)")
	assert_eq(_test_resource.template_texture, "xyz", "the template texture should be 'xyz'") 
	assert_eq(_test_resource.template_color, Color.white, "the color should be 'white'") 
	


# test remove all file
func test_remove_save_file():
	gut.p('=> \tTestting delete all file')
	
	# create file
	var _x = ResourceSaver.save("res://save_files/map_symbol_templates/{x_id}_save_data.tres".format({"x_id":"xyz_1"}), MapSymbolTemplate.new())
	var _y = ResourceSaver.save("res://save_files/map_symbol_templates/{y_id}_save_data.tres".format({"y_id":"xyz_2"}), MapSymbolTemplate.new())
	var _z = ResourceSaver.save("res://save_files/map_symbol_templates/{z_id}_save_data.tres".format({"z_id":"xyz_3"}), MapSymbolTemplate.new())
	
	test_pin_system_node.remove_all_files()
	
	# assertion
	assert_file_does_not_exist("res://save_files/map_symbol_templates/{x_id}_save_data.tres".format({"x_id":"xyz_1"}))
	assert_file_does_not_exist("res://save_files/map_symbol_templates/{y_id}_save_data.tres".format({"y_id":"xyz_2"}))
	assert_file_does_not_exist("res://save_files/map_symbol_templates/{z_id}_save_data.tres".format({"z_id":"xyz_3"}))

# test remove a file
func test_remove_specific_save_file():
	gut.p('=> \tTestting delete sepecific file')
	# creates file
	var _x = ResourceSaver.save("res://save_files/map_symbol_templates/{id}_save_data.tres".format({"id": "pqr"}), MapSymbolTemplate.new())

	test_pin_system_node.remove_file("pqr")

	# assertion
	assert_file_does_not_exist("res://save_files/map_symbol_templates/{id}_save_data.tres".format({"id": "pqr"}))
