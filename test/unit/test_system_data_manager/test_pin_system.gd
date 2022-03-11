extends RootSystemTest

var _temp_resource:Resource    = preload("res://test/resources_and_temp_items/temp_test_resource.tres")

func test_make_new_file():
	var uuid = PinSystem.make_new_pin(
		"home",
		MapSymbolTemplate.new(),
		Vector2(20, 100),
		Article.new(),
		true,
		Vector2(0,0),
		[
			"home",
			"safe",
			"country side"
		]
	)

	# asserstions

	yield(get_tree().create_timer(0.5), "timeout")

	var _x = ResourceManager.open_file(uuid, ResourceManager.PIN)

	assert_file_exists("res://save_files/pins/{uid}_save_data.tres".format({"uid" : uuid}))
	assert_eq(_x.pin_name, "home")
	assert_eq(_x.pin_id, uuid)
	assert_eq(_x.pin_location, Vector2(20, 100))
	assert_eq_deep(_x.tags, ["home", "safe", "country side"])

func test_add_chunk():
	var uuid = PinSystem.make_new_pin(
		"home",
		MapSymbolTemplate.new(),
		Vector2(20, 100),
		Article.new(),
		false,
		Vector2(0,0),
		[
			"home",
			"safe",
			"country side"
		]
	)
	
	yield(get_tree().create_timer(0.5), "timeout")

	# asserstions
	var chunk = Vector2(25, 10)

	PinSystem.add_chunk(uuid, chunk)
	
	yield(get_tree().create_timer(0.5), "timeout")

	var _x = ResourceManager.open_file(uuid, ResourceManager.PIN)

	assert_file_exists("res://save_files/pins/{uid}_save_data.tres".format({"uid" : uuid}))
	assert_eq(_x.pin_name, "home")
	assert_eq(_x.pin_id, uuid)
	assert_eq(_x.pin_location, Vector2(20, 100))

	assert_eq_deep(_x.linked_chunk, chunk)

func test_add_artilce():
	var uuid = PinSystem.make_new_pin(
		"home",
		MapSymbolTemplate.new(),
		Vector2(20, 100),
		Article.new(),
		false,
		Vector2(0,0),
		[
			"home",
			"safe",
			"country side"
		]
	)

	yield(get_tree().create_timer(0.5), "timeout")

	var article = load("res://test/resources_and_temp_items/temp_test_article.tres")

	PinSystem.add_article(uuid, article)
	
	yield(get_tree().create_timer(0.5), "timeout")
	
	var _x = ResourceManager.open_file(uuid, ResourceManager.PIN)

	assert_file_exists("res://save_files/pins/{uid}_save_data.tres".format({"uid" : uuid}))
	assert_eq(_x.pin_name, "home")
	assert_eq(_x.pin_id, uuid)
	assert_eq(_x.pin_location, Vector2(20, 100))
	assert_eq_deep(_x.pin_article, article)
	assert_eq_deep(_x.tags, ["home", "safe", "country side"])

func test_add_remove_tags():
	var uuid = PinSystem.make_new_pin(
		"home",
		MapSymbolTemplate.new(),
		Vector2(20, 100),
		Article.new(),
		false,
		Vector2(0,0),
		[
			"home",
			"safe",
			"country side"
		]
	)

	yield(get_tree().create_timer(0.5), "timeout")

	var _y = ResourceManager.open_file(uuid, ResourceManager.PIN)
	assert_eq_deep(_y.tags, ["home", "safe", "country side"])

	PinSystem.add_tags(uuid, ["book store", "city"])
	
	yield(get_tree().create_timer(0.5), "timeout")
	
	var _x = ResourceManager.open_file(uuid, ResourceManager.PIN)

	assert_file_exists("res://save_files/pins/{uid}_save_data.tres".format({"uid" : uuid}))
	assert_eq(_x.pin_name, "home")
	assert_eq(_x.pin_id, uuid)
	assert_eq(_x.pin_location, Vector2(20, 100))
	assert_eq_deep(_x.tags, ["home", "safe", "country side", "book store", "city"])

	PinSystem.remove_tags(uuid, ["home", "safe", "country side"])
	
	yield(get_tree().create_timer(0.5), "timeout")
	
	var _z = ResourceManager.open_file(uuid, ResourceManager.PIN)
	assert_eq_deep(_z.tags, ["book store", "city"])

func test_fetch_pin_by_tags_name():
	var uuid_1 = PinSystem.make_new_pin(
		"home",
		MapSymbolTemplate.new(),
		Vector2(20, 100),
		Article.new(),
		false,
		Vector2(0,0),
		[
			"home",
			"safe",
			"country side"
		]
	)

	var uuid_2 = PinSystem.make_new_pin(
		"book",
		MapSymbolTemplate.new(),
		Vector2(20, 100),
		Article.new(),
		false,
		Vector2(0,0),
		[
			"home",
			"country side"
		]
	)
	
	yield(get_tree().create_timer(1.0), "timeout")

	assert_file_exists("res://save_files/pins/{uid}_save_data.tres".format({"uid" : uuid_1}))
	assert_file_exists("res://save_files/pins/{uid}_save_data.tres".format({"uid" : uuid_2}))

	var pins_1:Array = PinSystem.get_pins_with_tag("safe")
	
	assert_eq(1, pins_1.size())
	assert_eq_deep([load("res://save_files/pins/{uid}_save_data.tres".format({"uid" : uuid_1}))], pins_1)
	
	var pins_2:Array = PinSystem.get_pins_with_tag("home")
	
	assert_eq(2, pins_2.size())
	assert_true(pins_2.has(load("res://save_files/pins/{uid}_save_data.tres".format({"uid" : uuid_2}))))
	assert_true(pins_2.has(load("res://save_files/pins/{uid}_save_data.tres".format({"uid" : uuid_2}))))
