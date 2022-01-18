class_name RootCommandTest
extends RootSystemTest

var C_API:Node
var console:Node

func before_each():
	test_scene = add_child_autoqfree(preload("res://singletone/CommandSystem.tscn").instance())
	test_scene.command_line_state = true

	C_API      = test_scene.get_node("CommandAPI")
	console    = test_scene.get_node("CanvasLayer/CommandSystemInterface/Console/Log")
