extends "res://addons/gut/test.gd"

var _test_script           = preload("res://singletone/SaveSystem.gd")
var test_script

func remove_files():
	var _x = Directory.new()
	_x.remove("res://save_files/map_data.tres")

func before_each():
	remove_files()
	test_script = _test_script.new()
	test_script.mapPin = load("res://assets/file templates/save_system_template/map_pin_resources_template.gd")

func test_create_file():
	var _a = Resource.new()
	test_script._save_map_pin("pikachu", _a, Vector2(0,0), _a, true, _a)
	assert_file_exists('res://save_files/save_location_data.tres')

func after_each():
	test_script.free()
