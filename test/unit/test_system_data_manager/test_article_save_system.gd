extends RootSystemTest

var _temp_resource       = preload("res://test/resources_and_temp_items/temp_test_resource.tres")
var test_article_system_node:Node

# === BEFORE ===

func before_each():
	# instance of the gd script
	test_scene               = add_child_autoqfree(preload("res://singletone/SystemDataManager.tscn").instance())
	test_article_system_node = test_scene.get_node("ArticleSystem").get_node("SaveSystem")

# === TESTS === 

# test the save file method 
func test_create_save_files():
	var uuid = test_scene.uuid_util.v4()
	var article_save_file:String = "res://save_files/articles/{uid}_save_data.tres".format({"uid" : uuid})
	

	gut.p('=> \tTestting save file method')
	test_article_system_node.save_file(
			"temp_article_name",
			uuid,
			"pqr",
			"temp data",
			["books", "house"]
	)
	
	# assertion
	assert_file_exists(article_save_file)

# test open the save file
func test_file_open():
	gut.p('Testting open file method')
	var uuid = test_scene.uuid_util.v4()
	
	test_article_system_node.save_file(
			"fake_name",
			uuid,
			"pqr",
			"temp data",
			["books", "house"]
	)

	# open files
	var _test_resource = test_article_system_node.open_file(uuid)

	# assertion
	gut.p('\n=> \tTest Data\n')
	assert_eq(_test_resource.article_name, "fake_name", "the article name should be 'fake_name'") 
	assert_eq(_test_resource.article_id, uuid, "the article id should be `{id}'".format({"id": uuid}))
	assert_eq(_test_resource.banner, "pqr", "the article banner should be `pqr")
	assert_eq(_test_resource.raw_data, "temp data", "the article banner should be `temp data")
	assert_eq_deep(_test_resource.tags, ["books", "house"])

# test verify files
func test_file_verification_recreation():
	var uuid = test_scene.uuid_util.v4()
	var xyz_save_file:String = "res://save_files/articles/{id}_save_data.tres".format({"id":uuid})
	
	gut.p('=> \tTestting file verification method')
	test_scene.verify(xyz_save_file, test_scene.MAP_RESOURCE_TYPE.ARTICLE, uuid)
	
	# assertion
	assert_file_exists(xyz_save_file)
	
	# open files
	var _test_resource = test_article_system_node.open_file(uuid)

	# assertion
	gut.p('\n=> \tTest Data\n')
	assert_eq(_test_resource.article_name, "", "the article name should be 'fake_name'") 
	assert_eq(_test_resource.article_id, uuid, "the article id should be '{id}'".format({"id": uuid}))
	assert_eq(_test_resource.banner, "xyz", "the article banner should be 'xyz'")
	assert_eq(_test_resource.raw_data, "", "the article banner should be ''")
	assert_eq(_test_resource.tags.size(), 0, "the no. tags should be '0'")
	assert_eq_deep(_test_resource.tags, [])


# test remove all file
func test_remove_save_file():
	gut.p('=> \tTestting delete all file')
	
	var uuid_x = test_scene.uuid_util.v4()
	var uuid_y = test_scene.uuid_util.v4()
	var uuid_z = test_scene.uuid_util.v4()

	# create file
	var _x = ResourceSaver.save("res://save_files/articles/{x_id}_save_data.tres".format({"x_id":uuid_x}), RootArticle.new())
	var _y = ResourceSaver.save("res://save_files/articles/{y_id}_save_data.tres".format({"y_id":uuid_y}), RootArticle.new())
	var _z = ResourceSaver.save("res://save_files/articles/{z_id}_save_data.tres".format({"z_id":uuid_z}), RootArticle.new())
	
	test_article_system_node.remove_all_files()
	
	# assertion
	assert_file_does_not_exist("res://save_files/articles/{x_id}_save_data.tres".format({"x_id":uuid_x}))
	assert_file_does_not_exist("res://save_files/articles/{y_id}_save_data.tres".format({"y_id":uuid_y}))
	assert_file_does_not_exist("res://save_files/articles/{z_id}_save_data.tres".format({"z_id":uuid_z}))

# test remove a file
func test_remove_specific_save_file():
	gut.p('=> \tTestting delete sepecific file')
	var uuid = test_scene.uuid_util.v4()
	
	# creates file
	var _x = ResourceSaver.save("res://save_files/articles/{id}_save_data.tres".format({"id": uuid}), RootArticle.new())

	test_article_system_node.remove_file(uuid)

	# assertion
	assert_file_does_not_exist("res://save_files/articles/{id}_save_data.tres".format({"id": uuid}))
