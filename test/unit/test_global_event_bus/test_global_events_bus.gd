extends GutTest

class TestMapSystemSignal extends GutTest:
	func test_scene_has_signal():
		gut.p('-- passing --')

		gut.p('=== MapSystem Resource ===')
		assert_has_signal(EventBus, 'reload_system')
		assert_has_signal(EventBus, 'save_map')
		assert_has_signal(EventBus, 'create_new_map')
		assert_has_signal(EventBus, 'change_map_to')
		assert_has_signal(EventBus, 'delete_current_map')

		gut.p('=== map layer ===')
		assert_has_signal(EventBus, 'create_new_layer')
		assert_has_signal(EventBus, 'change_layer_index')
		assert_has_signal(EventBus, 'assign_layer')
		assert_has_signal(EventBus, 'save_map_layer')

		gut.p('=== map element ===')
		assert_has_signal(EventBus, 'mouse_inside_map_element')
		assert_has_signal(EventBus, 'mouse_outside_map_element')

		gut.p('=== map pin ===')
		assert_has_signal(EventBus, 'create_new_pin')
		assert_has_signal(EventBus, 'remove_map_pin')
		assert_has_signal(EventBus, 'save_map_pin')
		assert_has_signal(EventBus, 'add_pin_to_map')
		assert_has_signal(EventBus, 'move_pin_to_top')

		gut.p('=== text ===')
		assert_has_signal(EventBus, 'create_new_text')
		assert_has_signal(EventBus, 'remove_map_text')
		assert_has_signal(EventBus, 'save_map_text')
		assert_has_signal(EventBus, 'add_text_to_map')
		
		gut.p('=== comments ===')
		assert_has_signal(EventBus, 'create_new_comment')
		assert_has_signal(EventBus, 'remove_map_comment')
		assert_has_signal(EventBus, 'save_map_comment')
		assert_has_signal(EventBus, 'add_comment_to_map')

		gut.p('=== symbol template ===')
		assert_has_signal(EventBus, 'create_new_symbol_template')
		assert_has_signal(EventBus, 'remove_map_symbol_template')
		assert_has_signal(EventBus, 'save_map_symbol_template')

		gut.p('=== Inspector System ===')
		assert_has_signal(EventBus, 'toggle_inpector')
		assert_has_signal(EventBus, 'change_inspector_state')
		assert_has_signal(EventBus, 'add_pin_inspector')
		assert_has_signal(EventBus, 'add_text_inspector')
		assert_has_signal(EventBus, 'add_comment_inspector')
		assert_has_signal(EventBus, 'clear_inspector')

		gut.p('=== Article System ===')
		assert_has_signal(EventBus, 'open_article_panel')
		assert_has_signal(EventBus, 'close_article_panel')

		gut.p('=== Map Symbol template ===')
		assert_has_signal(EventBus, 'load_pin_template')
		
		gut.p('=== Layer Option System ===')
		assert_has_signal(EventBus, 'set_visiblity')
		assert_has_signal(EventBus, 'set_layer_opacity')
		assert_has_signal(EventBus, 'set_layer_blend_mode')
		assert_has_signal(EventBus, 'set_map_layer')

# ------------------------------------------------------------------------------

class TestMapSystemConnect extends GutTest:

	func test_map_system_siganl_connected_with_event_bus()->void:
		var temp_scene = load("res://systems/map_system/MapSystem.gd").new()
		autofree(temp_scene)

		assert_connected(EventBus, temp_scene, 'reload_system', 'reload_system')
		assert_connected(EventBus, temp_scene, 'change_map_to', '_on_change_map_to')
		assert_connected(EventBus, temp_scene, 'delete_current_map', '_on_current_delete_map')

# ------------------------------------------------------------------------------

	func test_map_system_objects_signal_connected_with_event_bus()->void:
		var map_system_class = load("res://systems/map_system/dependency/map_system.gd").new()

		autofree(map_system_class)

		assert_connected(EventBus, map_system_class, 'save_map', '_on_save_map')
		assert_connected(EventBus, map_system_class, 'create_new_map', '_on_create_new_map')

# ------------------------------------------------------------------------------

	func test_map_comment_object_signal_connect_with_event_bus()->void:
		var map_system_class = load("res://systems/map_system/dependency/map_system.gd").new()
		autofree(map_system_class)

		var control_node     = Control.new()
		var camera_node      = Camera2D.new()

		var map_loader       = map_system_class.MapManager.new(control_node, control_node, control_node, camera_node)
		autofree(map_loader)

		var map_comment_object = load('res://systems/map_system/dependency/map_comment_system.gd').new(control_node, control_node, MapData.new())
		autofree(map_comment_object)

		assert_connected(EventBus, map_comment_object, 'create_new_comment', 'create_new_comment')
		assert_connected(EventBus, map_comment_object, 'remove_map_comment', 'remove_map_comment')
	
		control_node.free()
		camera_node.free()

# ------------------------------------------------------------------------------

	func test_camera()->void:
		# var temp_scene:PackedScene = preload("res://systems/map_system/MapSystem.tscn")
		# var map_system = temp_scene.instance()
		
		# add_child_autoqfree(map_system)
		# yield(get_tree().create_timer(5.0), "timeout")
		
		var camera_system = load('res://systems/map_system/scripts/map_camera.gd').new()
		add_child_autofree(camera_system)

		assert_connected(EventBus, camera_system, 'disable_camera', 'set_disable_camera')
		assert_connected(EventBus, camera_system, 'move_camera_to', '_on_move_camera_to')
		assert_connected(EventBus, camera_system, 'zoom_in', '_on_ZoomIn_pressed')
		assert_connected(EventBus, camera_system, 'zoom_out', '_on_ZoomOut_pressed')
		assert_connected(EventBus, camera_system, 'reset_zoom', '_on_Rest_pressed')

		
# ------------------------------------------------------------------------------

func before_all()->void:
	var root_system_test = RootSystemTest.new()
	root_system_test.clean_system_save_files()
