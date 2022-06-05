extends GutTest

# test map system 
class TestMapSystem extends GutTest:

	var temp_test_script = preload('res://systems/map_system/dependency/map_system.gd')
	var test_script      = null 

	# run before all the test
	# this clean the save folder for testing
	func before_all()->void:
		var root_system_test = RootSystemTest.new()
		root_system_test.clean_system_save_files()

# ------------------------------------------------------------------------------

	func before_each()->void:
		test_script = temp_test_script.new()
		autofree(test_script)

# ------------------------------------------------------------------------------

	func test_on_create_new_map()->void:
		watch_signals(EventBus)

		EventBus.emit_signal('create_new_map', 'blue', 'green', false)

		assert_signal_emitted(EventBus, 'create_new_map')

		yield(get_tree().create_timer(2.0), "timeout")

		assert_file_exists('res://save_files/maps/blue_save_data.tres')
		var resource:MapData = load('res://save_files/maps/blue_save_data.tres')
		
		assert_eq(resource.map_name, 'blue')
		assert_eq(resource.image_path, 'green')

# ------------------------------------------------------------------------------

	func test_on_save_map()->void:
		watch_signals(EventBus)

		var new_resouce = MapData.new()
		new_resouce.map_name   = 'blue'
		new_resouce.image_path = 'green'

		EventBus.emit_signal("save_map", new_resouce)
		assert_signal_emitted(EventBus, "save_map")

		yield(get_tree().create_timer(2.0), "timeout")

		assert_file_exists('res://save_files/maps/blue_save_data.tres')
		var test_resource:MapData = load('res://save_files/maps/blue_save_data.tres')

		assert_eq(test_resource.map_name, new_resouce.map_name)
		assert_eq(test_resource.image_path, new_resouce.image_path)

		var new_resouce_2 = MapData.new()
		new_resouce_2.map_name   = 'pink'
		new_resouce_2.image_path = 'green'
		
		EventBus.emit_signal("save_map", new_resouce_2)
		assert_signal_emitted(EventBus, "save_map")

		yield(get_tree().create_timer(2.0), "timeout")

		assert_file_exists('res://save_files/maps/blue_save_data.tres')

		var test_resource_2:MapData = load('res://save_files/maps/pink_save_data.tres')
		assert_eq(test_resource_2.map_name, new_resouce_2.map_name)
		assert_eq(test_resource_2.image_path, new_resouce_2.image_path)

# ------------------------------------------------------------------------------

	func after_all()->void:
		var root_system_test = RootSystemTest.new()
		root_system_test.clean_system_save_files()


# ------------------------------------------------------------------------------


class TestMapLoadSystem extends GutTest:

	var temp_test_script = preload('res://systems/map_system/dependency/map_system.gd')
	var test_script      = null 

	# run before all the test
	# this clean the save folder for testing
	func before_all()->void:
		var root_system_test = RootSystemTest.new()
		root_system_test.clean_system_save_files()

# ------------------------------------------------------------------------------

	func before_each()->void:
		var option_button = OptionButton.new()

		var temp_test_script_2 = temp_test_script.new()
		test_script = temp_test_script_2.MapLoadSystem.new(option_button)
		
		autofree(temp_test_script_2)
		autofree(test_script)
		add_child_autoqfree(option_button)

# ------------------------------------------------------------------------------
	
	func test_assign_map_name()->void:
		watch_signals(test_script.option_node)
		test_script.assign_map_name()

		assert_signal_emitted(test_script.option_node, 'item_selected')
		assert_eq_deep(test_script.map_list, {})


# ------------------------------------------------------------------------------


class TestMapManagerSystem extends GutTest:

	var temp_test_script          = preload("res://systems/map_system/dependency/map_system.gd").new()
	var test_script               = null 
	var container:Control         = null
	var pin_container:Control     = null
	var comment_container:Control = null
	
	# run before all the test
	# this clean the save folder for testing
	func before_all()->void:
		var root_system_test = RootSystemTest.new()
		root_system_test.clean_system_save_files()

# ------------------------------------------------------------------------------

	func before_each()->void:
		var camera = preload("res://systems/map_system/scripts/map_camera.gd").new()
		autofree(camera)
		
		container = Control.new()
		add_child_autoqfree(container)

		pin_container = Control.new()
		add_child_autoqfree(pin_container)
	
		comment_container = Control.new()
		add_child_autoqfree(comment_container)

		test_script = temp_test_script.MapManager.new(pin_container, comment_container, container, camera)
		autofree(test_script)
		
# ------------------------------------------------------------------------------

	func test_assign_map_name()->void:
		watch_signals(EventBus)
		test_script.map_resource = load("res://test/test_resources/map_save_data.tres")
		test_script.assign_texture()

		yield(get_tree().create_timer(2.0), "timeout")
		assert_eq(container.get_child_count(), 1)
		
		assert_signal_emitted(EventBus, 'assign_layer')

# ------------------------------------------------------------------------------

	func test_add_texture()->void:
		var texture = TextureRect.new()
		test_script.add_texture_node(texture)
		assert_eq(container.get_child_count(), 1)
		texture.queue_free()

# ------------------------------------------------------------------------------
 
	func test_add_map_pin()->void:
		test_script.map_resource = load("res://test/test_resources/map_save_data.tres")
		test_script.add_map_pins()

		yield(get_tree().create_timer(2.0), "timeout")
		assert_eq(pin_container.get_child_count(), 1)

# ------------------------------------------------------------------------------
 
	func test_add_map_comments()->void:
		test_script.map_resource = load("res://test/test_resources/map_save_data.tres")
		test_script.add_map_comments()

		yield(get_tree().create_timer(2.0), "timeout")
		assert_eq(comment_container.get_child_count(), 1)

# ------------------------------------------------------------------------------

	func test_map_creation()->void:
		var test_resource = load("res://test/test_resources/map_save_data.tres")
		
		test_script.map_resource = test_resource
		test_script.load_map_texture("res://test/test_resources/map_save_data.tres")

		yield(get_tree().create_timer(2.0), "timeout")

		assert_eq(container.get_child_count(), 1)
		assert_eq(pin_container.get_child_count(), 1)
		assert_eq(comment_container.get_child_count(), 1)


