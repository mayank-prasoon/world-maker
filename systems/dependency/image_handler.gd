class_name ImageHandler
extends Reference

# load the image
static func load_image(image_path:String)->Image:
	var new_image:Image = Image.new()
	var _error:int = new_image.load(image_path)
	
	return new_image

static func load_image_texture(image_path:String) -> ImageTexture:
	var new_texture:ImageTexture = ImageTexture.new()
	
	var new_image:Image = Image.new()
	var OK:int = new_image.load(image_path)

	if !(OK == 0):
		var temp_image:Image = Image.new()
		temp_image.create(1000,1000, true, Image.FORMAT_RGB8)
		temp_image.fill(Color.dimgray)

		new_texture.create_from_image(temp_image) 
	else:
		new_texture.create_from_image(new_image) 
	
	return new_texture
