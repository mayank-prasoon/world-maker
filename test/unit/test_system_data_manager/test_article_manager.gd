extends RootSystemTest

var test_pin_system_node:Node
var save_file_node:Node

func test_get_tags():
	gut.p('Testing get method method')

	var uuid = UUID.generate()

	ResourceManager.save_file(
		{
			'article_name'     : "temp_file_1",
			'article_id'       : uuid,
			'article_profile'  : "xyz",
			'article_banner'   : "xyz",
			'article_type'     : 0,
			'article_template' : Resource.new(),
			'article_raw'      : "",
			'tags'             : [
				"random",
				"568",
				"diginemo"
			]
		},

		ResourceManager.ARTICLE
	)
	
	yield(get_tree().create_timer(0.5), "timeout")

	# open files
	var _test_resource = ArticleManager.get_tags(uuid)

	# assertion
	gut.p('\n=> \tTest Data\n')
	assert_eq(_test_resource.size(), 3, "the name should be '3'")
	assert_eq_deep(_test_resource,   ["random", "568", "diginemo"])
