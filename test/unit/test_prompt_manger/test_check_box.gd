extends "res://addons/gut/test.gd"

var t = preload("res://systems/dependency/ui_elements/input_check_box/InputCheckBox.tscn")
var test_scene:Node

func before_each():
	test_scene = t.instance()
	test_scene.input_name             = "test"
	test_scene.input_description      = "testing check box input"
	test_scene.input_display          = "this is a test of check_box, {value}, these are the item that are being displayed"
	test_scene.input_check_box_option = ['op1', 'op2', 'op3']

func test__display_all():
	test_scene.input_value            = [true, true, true]
	add_child_autofree(test_scene)
	assert_eq(test_scene.dispaly(), "this is a test of check_box, {value}, these are the item that are being displayed".format({'value' : 'op1, op2 and op3'}))

func test__display_op1_op2():
	test_scene.input_value            = [true, true, false]
	add_child_autofree(test_scene)
	assert_eq(test_scene.dispaly(), "this is a test of check_box, {value}, these are the item that are being displayed".format({'value' : 'op1 and op2'}))

func test__display_op1_op3():
	test_scene.input_value            = [true, false, true]
	add_child_autofree(test_scene)
	assert_eq(test_scene.dispaly(), "this is a test of check_box, {value}, these are the item that are being displayed".format({'value' : 'op1 and op3'}))

func test__display_op2_op3():
	test_scene.input_value            = [false, true, true]
	add_child_autofree(test_scene)
	assert_eq(test_scene.dispaly(), "this is a test of check_box, {value}, these are the item that are being displayed".format({'value' : 'op2 and op3'}))

func test__display_op1():
	test_scene.input_value            = [true, false, false]
	add_child_autofree(test_scene)
	assert_eq(test_scene.dispaly(), "this is a test of check_box, {value}, these are the item that are being displayed".format({'value' : 'op1'}))

func test__display_op2():
	test_scene.input_value            = [false, true, false]
	add_child_autofree(test_scene)
	assert_eq(test_scene.dispaly(), "this is a test of check_box, {value}, these are the item that are being displayed".format({'value' : 'op2'}))

func test__display_op3():
	test_scene.input_value            = [false, false, true]
	add_child_autofree(test_scene)
	assert_eq(test_scene.dispaly(), "this is a test of check_box, {value}, these are the item that are being displayed".format({'value' : 'op3'}))

func test__display_nothing():
	test_scene.input_value            = [false, false, false]
	add_child_autofree(test_scene)
	assert_eq(test_scene.dispaly(), "this is a test of check_box, {value}, these are the item that are being displayed".format({'value' : 'nothing'}))





