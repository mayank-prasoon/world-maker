extends RootCommandTest

func test_log():
	C_API.echo("fire")
	assert_eq_deep(C_API.console_log, ["fire"])

	C_API.echo("book")
	assert_eq_deep(C_API.console_log, ["fire", "book"])

	C_API.echo(56)
	assert_eq_deep(C_API.console_log, ["fire", "book", "56"])

func test_clear_command():
	C_API.echo("fire")
	assert_eq_deep(C_API.console_log, ["fire"])

	C_API.echo("book")
	assert_eq_deep(C_API.console_log, ["fire", "book"])

	assert_eq(console.get_child_count(), 2)
	C_API.clear()
	assert_eq(console.get_child_count(), 0)

func test_ls_console_log():
	C_API.echo("fire")
	assert_eq_deep(C_API.console_log, ["fire"])
	
	C_API.ls_console_log()
	assert_eq_deep(C_API.console_log, ["fire", "fire"])
	assert_eq(C_API.console_log.size(), 2)
	assert_eq(console.get_child_count(), 4)

func test_ls_command_used():
	test_scene.execute_command("echo('fire')")
	assert_eq_deep(C_API.console_log, ["fire"])

	C_API.ls_command_history()
	assert_eq_deep(C_API.console_log, ["fire", "echo('fire')"])
	assert_eq(C_API.console_log.size(), 2)
	assert_eq(console.get_child_count(), 4)
	
	test_scene.execute_command("pikachu")
	C_API.ls_command_history()
	assert_eq_deep(C_API.console_log, ["fire", "echo('fire')", "failed to exicute command `pikachu`", "echo('fire')"])
	assert_eq(C_API.console_log.size(), 4)
	assert_eq(console.get_child_count(), 8)

func test_clear_save_files():
	var _x = ResourceSaver.save("res://save_files/pins/pikachu.tres", MapPin.new())
	var _y = ResourceSaver.save("res://save_files/maps/pikachu.tres", MapData.new())
	var _z = ResourceSaver.save("res://save_files/map_symbol_templates/pikachu.tres", MapSymbolTemplate.new())
	var _q = ResourceSaver.save("res://save_files/articles/pikachu.tres", Article.new())

	assert_file_exists("res://save_files/pins/pikachu.tres")
	assert_file_exists("res://save_files/maps/pikachu.tres")
	assert_file_exists("res://save_files/map_symbol_templates/pikachu.tres")
	assert_file_exists("res://save_files/articles/pikachu.tres")

	C_API.remove_save_files()

	assert_file_does_not_exist("res://save_files/pins/pikachu.tres")
	assert_file_does_not_exist("res://save_files/maps/pikachu.tres")
	assert_file_does_not_exist("res://save_files/map_symbol_templates/pikachu.tres")
	assert_file_does_not_exist("res://save_files/articles/pikachu.tres")

func test_run_script():
	C_API.run_script("res://test/resources_and_temp_items/hello_world.gd")
	assert_file_exists("res://save_files/pins/hello_world.tres")
