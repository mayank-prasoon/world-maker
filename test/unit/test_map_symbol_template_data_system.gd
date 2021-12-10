extends "res://addons/gut/test.gd"

# === TESTS FOR THE SAVE SYSTEM FILE ===
var _temp_resource:Resource = ResourceLoader.load("res://test/resources_and_temp_items/temp_test_resource.tres")

var test_scene:Node
var test_template_system_node:Node

# === METHODS FOR THE TESTS ===



# === BEFORE ===


func before_each():
	# instance of the gd script
	test_scene = add_child_autoqfree(load("res://singletone/SaveSystem.tscn").instance())
	test_template_system_node = test_scene.get_child(1)

# === TESTS === 

# test the save file method 
func test_create_save_files():
	var template_save_file:String = "res://save_files/symbol_templates/temp_symbol_templates_name_save_data.tres"

	# delete file
	var _x = Directory.new()
	_x.remove(template_save_file)
	
	gut.p('=> \tTestting save file method')
	test_template_system_node._save_file("temp_symbol_templates_name", "xyz", Vector2(0,0), Color.red)
	
	# assertion
	assert_file_exists(template_save_file)

# test open the save file
func test_file_open():
	gut.p('Testting open file method')

	# open files
	var _test_resource = test_template_system_node._open_file("temp_symbol_templates_name")

	# assertion
	gut.p('\n=> \tTest Data\n')
	assert_eq(_test_resource.template_name, "temp_symbol_templates_name", "the name should be 'temp_symbol_templates_name'") 
	assert_eq(_test_resource.template_offset, Vector2(0,0), "the offset location should be `Vector2(0,0)")
	assert_eq(_test_resource.template_color, Color.red, "the color sould be red")
	assert_eq(_test_resource.template_texture, "xyz", "the resource file sould be xyz")

# test verify files
func test_file_verification_recreation():
	var xyz_save_file:String = "res://save_files/symbol_templates/xyz_save_data.tres"
	
	# remove files
	var _x = Directory.new()
	_x.remove(xyz_save_file)
	
	gut.p('=> \tTestting file verification method')
	test_scene.verify(xyz_save_file, test_scene.MAP_RESOURCE_TYPE.PIN_TEMPLATE, 'xyz')
	assert_file_exists(xyz_save_file)
#	pending('verification currently in development')

# test remove all file
func test_remove_save_file():
	gut.p('=> \tTestting delete all file')
	
	# create file
	var _x = ResourceSaver.save("res://save_files/symbol_templates/xyz1_save_data.tres", MapPin.new())
	var _y = ResourceSaver.save("res://save_files/symbol_templates/xyz2_save_data.tres", MapPin.new())
	var _z = ResourceSaver.save("res://save_files/symbol_templates/xyz3_save_data.tres", MapPin.new())
	
	test_template_system_node._remove_all_file()
	
	# assertion
	assert_file_does_not_exist("res://save_files/symbol_templates/xyz1_save_data.tres")
	assert_file_does_not_exist("res://save_files/symbol_templates/xyz2_save_data.tres")
	assert_file_does_not_exist("res://save_files/symbol_templates/xyz3_save_data.tres")

# test remove a file
func test_remove_specific_save_file():
	gut.p('=> \tTestting delete sepecific file')
	
	# creates file
	var _x = ResourceSaver.save("res://save_files/symbol_templates/pqr_save_data.tres", MapPin.new())

	test_template_system_node._remove_file("res://save_files/symbol_templates/pqr_save_data.tres")

	# assertion
	assert_file_does_not_exist("res://save_files/symbol_templates/pqr_save_data.tres")

# === AFTER ===

func after_each():
	gut.p('\n')
