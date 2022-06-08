extends GutTest

class TestFileChecker extends GutTest:
	
	func test_check_file_exists()->void:
		# this file exists
		var path = '/home/mayank/Downloads/pexels-tetyana-kovyrina-1692984.jpg'
		var test_value = ResourceLoadSystem.FileChecker.check_file_exists(path)
		
		# test
		assert_eq(test_value, ResourceLoadSystem.FileChecker.OK)
		
		# this file doesn't exists
		var path_2 = '/home/mayank/Downloads/pexels-tetyana-kovyrina-1692985.jpg'
		var test_value_2 = ResourceLoadSystem.FileChecker.check_file_exists(path_2)
		
		# test 2
		assert_eq(test_value_2, ResourceLoadSystem.FileChecker.NOT_FOUND)

# ------------------------------------------------------------------------------

class TestFileLoader extends GutTest:
	
	func test_load_resource()->void:
		var path = "res://test/test_resources/map_save_data.tres"
		var resource = load(path)
		var test_resource = ResourceLoadSystem.LoadResource.load_resource(path)
		
		assert_eq(test_resource, resource)

# ------------------------------------------------------------------------------

class TestThreadFileLoader extends GutTest:
	
	func test_load_on_thread()->void:
		var path = "res://test/test_resources/map_save_data.tres"
		var resource = load(path)

		var test_node = double("res://test/test_resources/test_object.gd").new()
		var load_on_thread = ResourceLoadSystem.ThreadLoad.new(test_node, '_thread_reciver', path)
		
		yield(get_tree().create_timer(2.0), "timeout")
		
		assert_called(test_node, '_thread_reciver', [resource])

# ------------------------------------------------------------------------------

class TestCheckFolderIntregety extends GutTest:
	const PATH:String = "res://test/test_resources/test_folder/cat/mouse.tres"
	

	# delete all the folder and files
	func before_all()->void:
		var dir = Directory.new()
		dir.remove(PATH.get_base_dir())

# ------------------------------------------------------------------------------

	func test_check()->void:
		ResourceSaveSystem.CheckFolderIntregety.check(PATH)
		var dir = Directory.new()

		var folder_exists = dir.dir_exists(PATH.get_base_dir())
		
		assert_true(folder_exists)

# ------------------------------------------------------------------------------

	# delete all the folder and files
	func after_all()->void:
		var dir = Directory.new()
		dir.remove(PATH.get_base_dir())

class TestSaveThead extends GutTest:
	const PATH:String     = "res://test/test_resources/test_folder/mouse.tres"
	
	var resource:Resource = Resource.new()
	
	func after_all()->void:
		var dir = Directory.new()
		dir.remove(PATH)
	
	func test_save_thead()->void:
		var save_on_thread = ResourceSaveSystem.SaveThead.new(PATH, resource)
		yield(get_tree().create_timer(2.0), "timeout")
		assert_file_exists(PATH)
		
class TestResourceSystem extends GutTest:
	const NEW_PATH:String = "res://test/test_resources/test_folder/map_save_data.tres"
	const PATH:String     = "res://test/test_resources/map_save_data.tres"

	func clean_folder()->void:
		var dir = Directory.new()
		dir.remove(NEW_PATH)

	func before_all()->void:
		clean_folder()

	func after_each()->void:
		clean_folder()

	func test_move()->void:
		ResourceSystem.MoveSystem.move(PATH, NEW_PATH)
		assert_file_exists(NEW_PATH)

	func test_image_cache()->void:
		var path = "res://assets/graphics/main_menu/water-lily-1592793.png"
		ResourceSystem.CacheSystem.create_image_cache(path, NEW_PATH)
		yield(get_tree().create_timer(2.0), "timeout")
		assert_file_exists(NEW_PATH)
