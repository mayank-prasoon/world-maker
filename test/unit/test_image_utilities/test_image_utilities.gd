extends GutTest

class TestImageLoader extends GutTest:
	const PATH = "res://assets/graphics/main_menu/water-lily-1592793.png"
	
	func test_load_image()->void:
		var test_image = ImageUtilities.ImageLoader.load_image(PATH)
		
		assert_not_null(test_image)
		assert_extends(test_image, Image)

	func test_load_image_texture()->void:
		var test_image = ImageUtilities.ImageLoader.load_image_texture(PATH)

		assert_not_null(test_image)
		assert_extends(test_image, ImageTexture)

# ------------------------------------------------------------------------------

class TestImageResize extends GutTest:
	var image:Image = Image.new()
	var texture:ImageTexture = ImageTexture.new()
	
	func before_each()->void:
		texture.create_from_image(image.create(500, 500, true, Image.FORMAT_BPTC_RGBA))
	
	func test_image_resize()->void:
		var test_image_1 = ImageUtilities.ImageResize.resize_image(texture.duplicate(), ImageUtilities.ImageResize.ICON)
		var test_image_2 = ImageUtilities.ImageResize.resize_image(texture.duplicate(), ImageUtilities.ImageResize.MAP_PIN)
		var test_image_3 = ImageUtilities.ImageResize.resize_image(texture.duplicate(), ImageUtilities.ImageResize.THUMBNAIL)
		var test_image_4 = ImageUtilities.ImageResize.resize_image(texture.duplicate(), ImageUtilities.ImageResize.ARTICLE_PROFILE)

		assert_eq(test_image_1.get_size(), Vector2(25, 25))
		assert_eq(test_image_2.get_size(), Vector2(125, 125))
		assert_eq(test_image_3.get_size(), Vector2(250, 140))
		assert_eq(test_image_4.get_size(), Vector2(250, 250))
		
	func test_image_resize_to()->void:
		var test_image_1 = ImageUtilities.ImageResize.resize_image_to(texture.duplicate(), Vector2(50, 50))

		assert_eq(test_image_1.get_size(), Vector2(50, 50))

# ------------------------------------------------------------------------------

class TestThreadLoad extends GutTest:

	func test_load_though_thread()->void:
		var path:String = "res://assets/graphics/main_menu/water-lily-1592793.png"
		
		var test_node = double("res://test/test_resources/test_object.gd").new()
		var load_on_thread = ResourceLoadSystem.ThreadLoad.new(test_node, '_thread_reciver', path)

		yield(get_tree().create_timer(2.0), "timeout")
		assert_called(test_node, '_thread_reciver')
