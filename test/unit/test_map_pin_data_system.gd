extends "res://addons/gut/test.gd"

# === TESTS FOR THE SAVE SYSTEM FILE ===
var _temp_resource:Resource = ResourceLoader.load("res://test/resources_and_temp_items/temp_test_resource.tres")

var test_scene:Node
var test_pin_system_node:Node

# === METHODS FOR THE TESTS ===



# === BEFORE ===


func before_each():
	# instance of the gd script
	test_scene = add_child_autoqfree(load("res://singletone/SaveSystem.tscn").instance())
	test_pin_system_node = test_scene.get_child(0)

# === TESTS === 

# test the save file method 
func test_create_save_files():
	var pin_save_file:String = "res://save_files/pins/temp_pin_name_save_data.tres"

	# delete file
	var _x = Directory.new()
	_x.remove(pin_save_file)
	
	gut.p('=> \tTestting save file method')
	test_pin_system_node._save_file("temp_pin_name", _temp_resource, Vector2(0,0), _temp_resource, true, _temp_resource)
	
	# assertion
	assert_file_exists(pin_save_file)

# test open the save file
func test_file_open():
	gut.p('Testting open file method')

	# open files
	var _test_resource = test_pin_system_node._open_file("temp_pin_name")

	# assertion
	gut.p('\n=> \tTest Data\n')
	assert_eq(_test_resource.pin_name, "temp_pin_name", "the pin name should be 'temp_pin_name'") 
	assert_eq(_test_resource.pin_location, Vector2(0,0), "the pin location should be `Vector2(0,0)")
	assert_true(_test_resource.map_link_state, "the map_state_link should be True")

	gut.p('\n=> \tTest Resource File\n')
	assert_eq(_test_resource.pin_symbol_template, _temp_resource, "the resource file sould be same as _temp_resource")
	assert_eq(_test_resource.pin_article, _temp_resource, "the resource file sould be same as _temp_resource")
	assert_eq(_test_resource.linked_chunk, _temp_resource, "the resource file sould be same as _temp_resource")


# test verify files
func test_file_verification_recreation():
	var xyz_save_file:String = "res://save_files/pins/xyz_save_data.tres"
	
	# remove files
	var _x = Directory.new()
	_x.remove(xyz_save_file)
	
	gut.p('=> \tTestting file verification method')
	test_scene.verify(xyz_save_file, test_scene.MAP_RESOURCE_TYPE.PIN, 'xyz')
	assert_file_exists(xyz_save_file)
#	pending('verification currently in development')

# test remove all file
func test_remove_save_file():
	gut.p('=> \tTestting delete all file')
	
	# create file
	var _x = ResourceSaver.save("res://save_files/pins/xyz1_save_data.tres", MapPin.new())
	var _y = ResourceSaver.save("res://save_files/pins/xyz2_save_data.tres", MapPin.new())
	var _z = ResourceSaver.save("res://save_files/pins/xyz3_save_data.tres", MapPin.new())
	
	test_pin_system_node._remove_all_file()
	
	# assertion
	assert_file_does_not_exist("res://save_files/pins/xyz1_save_data.tres")
	assert_file_does_not_exist("res://save_files/pins/xyz2_save_data.tres")
	assert_file_does_not_exist("res://save_files/pins/xyz3_save_data.tres")

# test remove a file
func test_remove_specific_save_file():
	gut.p('=> \tTestting delete sepecific file')
	
	# creates file
	var _x = ResourceSaver.save("res://save_files/pins/pqr_save_data.tres", MapPin.new())

	test_pin_system_node._remove_file("res://save_files/pins/pqr_save_data.tres")

	# assertion
	assert_file_does_not_exist("res://save_files/pins/pqr_save_data.tres")

# === AFTER ===

func after_each():
	gut.p('\n')
