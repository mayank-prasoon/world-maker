extends "res://addons/gut/test.gd"

var editor_settings_node = load("res://singletone/EditorSetting.tscn")
var test_node:Node
var save_file            = "res://settings.tres"

func before_each():
	var dir = Directory.new()
	dir.remove(save_file)
	
	test_node = add_child_autoqfree(editor_settings_node.instance())


func test_add_new_project():
	var x = test_node.get_projects()
	assert_eq_deep(x, [])
	
	test_node.add_new_project("game_dev", "pqr")
	var y = test_node.get_projects()
	assert_eq_deep(y, [{"game_dev" : "pqr"}])

	test_node.add_new_project("world_building", "xyz")
	var z = test_node.get_projects()
	assert_eq_deep(z, [{"game_dev" : "pqr"}, {"world_building" : "xyz"}])

func test_remove_project():
	test_node.add_new_project("game_dev", "pqr")
	test_node.add_new_project("world_building", "xyz")
	var z = test_node.get_projects()
	assert_eq_deep(z, [{"game_dev" : "pqr"}, {"world_building" : "xyz"}])

	test_node.remove_project("game_dev", "pqr")
	var y = test_node.get_projects()
	assert_eq_deep(y, [{ "world_building" : "xyz"}])

func test_get_projects():

	var x = test_node.get_projects()
	assert_eq_deep(x, [])

	test_node.add_new_project("game_dev", "pqr")
	test_node.add_new_project("world_building", "xyz")

	var y:Array = test_node.get_projects()
	assert_eq_deep(y, [{"game_dev" : "pqr"}, {"world_building" : "xyz"}])

func test_last_project():
	test_node.add_new_project("game_dev", "pqr")
	test_node.add_new_project("world_building", "xyz")

	test_node.add_last_project(1)

	test_node.add_new_project("gg", "mno")

	var y:Array = test_node.get_projects()
	
	assert_eq_deep(y, [{"game_dev" : "pqr"}, {"world_building" : "xyz"}, {"gg" : "mno"}])
	assert_eq_deep(test_node.last_project(), {"world_building" : "xyz"})

func test_pinned_project():
	test_node.add_new_project("game_dev", "pqr")
	test_node.add_new_project("world_building", "xyz")

	test_node.pin_project(1)
	assert_eq_deep(test_node.get_pinned_project(), [1])

	test_node.pin_project(0)
	assert_eq_deep(test_node.get_pinned_project(), [1, 0])

	test_node.upin_project(1)
	assert_eq_deep(test_node.get_pinned_project(), [0])

