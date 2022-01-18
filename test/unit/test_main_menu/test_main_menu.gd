extends "res://addons/gut/test.gd"

var t = preload("res://systems/main_menu/MainMenu.tscn")
var test_scene:Node

func before_each():
	test_scene = t.instance()
	add_child_autofree(test_scene)

#test ui behavour
func test_on_NewProjectButton_pressed():
	test_scene._on_NewProjectButton_pressed()
	assert_true(test_scene.get_node("NewProject").visible)
	assert_false(test_scene.get_node("OpenProject").visible)
	assert_false(test_scene.get_node("VBoxContainer").visible)

func test_on_Button2_pressed():
	test_scene._on_Button2_pressed()
	assert_false(test_scene.get_node("NewProject").visible)
	assert_false(test_scene.get_node("OpenProject").visible)
	assert_true(test_scene.get_node("VBoxContainer").visible)
	assert_eq(test_scene.get_node("OpenProject/VBoxContainer").get_child_count(), 0)

func test_on_OpenProjectButton_pressed():
	test_scene._on_OpenProjectButton_pressed()
	assert_false(test_scene.get_node("NewProject").visible)
	assert_true(test_scene.get_node("OpenProject").visible)
	assert_false(test_scene.get_node("VBoxContainer").visible)
