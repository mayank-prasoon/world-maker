extends RootSystemTest

var test_pin_system_node:Node
var save_file_node:Node

func before_each():
	# instance of the gd script
	test_scene           = add_child_autoqfree(preload("res://singletone/SystemDataManager.tscn").instance())
	test_pin_system_node = test_scene.get_node("ArticleSystem").get_node("ArticleManager")
	save_file_node       = test_scene.get_node("ArticleSystem").get_node("SaveSystem")

func test_get_tags():
	gut.p('Testing get method method')

	var uuid = test_scene.uuid_util.v4()

	save_file_node.save_file(
			"temp_file_1",
			uuid,
			"xyz",
			"",
			[
				"random",
				"568",
				"diginemo"
			]
	)

	# open files
	var _test_resource = test_pin_system_node.get_tags(uuid)

	# assertion
	gut.p('\n=> \tTest Data\n')
	assert_eq(_test_resource.size(), 3, "the name should be '3'")
	assert_eq_deep(_test_resource,   ["random", "568", "diginemo"])
