extends "res://addons/gut/test.gd"

var test_script = preload("res://singletone/system_data_manager_dependency/map_system/map_chunk_generator.gd").new()

#func test_spiral_iterator():
#	print(test_script.spiral_iterator(25))

func test_slice_image():
	var x = test_script.slice_texture("x")
	print(x)
