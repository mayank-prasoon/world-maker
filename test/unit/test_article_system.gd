extends RootSystemTest

var _temp_resource:Resource    = preload("res://test/resources_and_temp_items/temp_test_resource.tres")
var test_article_system_node:Node
var save_system:Node

# === BEFORE ===

func before_each():
	# instance of the gd script
	test_scene               = add_child_autoqfree(preload("res://singletone/SystemDataManager.tscn").instance())
	test_article_system_node = test_scene.get_node("ArticleSystem")
	save_system              = test_scene.get_node("ArticleSystem").get_node("SaveSystem")

func test_make_new_file():
	var uuid = test_article_system_node.make_new_article(
		"home",
		"xyz",
		"sample text",
		[
			"home",
			"safe",
			"country side"
		]
	)

	# asserstions

	var _x = save_system.open_file(uuid)

	assert_file_exists("res://save_files/articles/{uid}_save_data.tres".format({"uid" : uuid}))
	assert_eq(_x.article_name, "home")
	assert_eq(_x.article_id, uuid)
	assert_eq(_x.banner, "xyz")
	assert_eq(_x.raw_data, "sample text")
	assert_eq_deep(_x.tags, ["home", "safe", "country side"])

	
func test_add_remove_tags():
	var uuid = test_article_system_node.make_new_article(
		"home",
		"xyz",
		"sample text",
		[
			"home",
			"safe",
			"country side"
		]
	)
	var _y = save_system.open_file(uuid)
	assert_eq_deep(_y.tags, ["home", "safe", "country side"])

	test_article_system_node.add_tags(uuid, ["book store", "city"])
	var _x = save_system.open_file(uuid)

	assert_file_exists("res://save_files/articles/{uid}_save_data.tres".format({"uid" : uuid}))
	assert_eq(_x.article_name, "home")
	assert_eq(_x.article_id, uuid)
	assert_eq(_x.banner, "xyz")
	assert_eq(_x.raw_data, "sample text")
	assert_eq_deep(_x.tags, ["home", "safe", "country side", "book store", "city"])

	test_article_system_node.remove_tags(uuid, ["home", "safe", "country side"])
	var _z = save_system.open_file(uuid)
	assert_eq_deep(_z.tags, ["book store", "city"])

func test_fetch_article_by_tags_name():
	var uuid_1 = test_article_system_node.make_new_article(
		"home",
		"xyz",
		"sample text",
		[
			"home",
			"safe",
			"country side"
		]
	)

	var uuid_2 = test_article_system_node.make_new_article(
		"shop",
		"xyz",
		"sample text",
		[
			"home",
			"country side"
		]
	)
	assert_file_exists("res://save_files/articles/{uid}_save_data.tres".format({"uid" : uuid_1}))
	assert_file_exists("res://save_files/articles/{uid}_save_data.tres".format({"uid" : uuid_2}))

	var pins_1:Array = test_article_system_node.get_articles_with_tag("safe")
	
	assert_eq(1, pins_1.size())
	assert_eq_deep([load("res://save_files/articles/{uid}_save_data.tres".format({"uid" : uuid_1}))], pins_1)
	
	var pins_2:Array = test_article_system_node.get_articles_with_tag("home")
	
	assert_eq(2, pins_2.size())
	assert_true(pins_2.has(load("res://save_files/articles/{uid}_save_data.tres".format({"uid" : uuid_1}))))
	assert_true(pins_2.has(load("res://save_files/articles/{uid}_save_data.tres".format({"uid" : uuid_2}))))
