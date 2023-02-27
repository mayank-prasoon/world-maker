class_name ImageHandler
extends RefCounted

# ------------------------------------------------------------------------------

# load the image
static func load_image(image_path:String)->Image:
	var new_image:Image = Image.new()
	var _error:int = new_image.load(image_path)
	new_image.fix_alpha_edges()

	return new_image

# ------------------------------------------------------------------------------

# load the image
static func load_image_texture(image_path:String, flag:int = Texture2D.FLAGS_DEFAULT) -> ImageTexture:
	var new_texture:ImageTexture = ImageTexture.new()
	
	var new_image:Image = Image.new()
	var _OK:int = new_image.load(image_path)
	new_texture.create_from_image(new_image) #,flag 
	
	return new_texture

# ------------------------------------------------------------------------------

# load icon
static func load_icon(image_path:String) -> ImageTexture:
	var new_texture:ImageTexture = ImageTexture.new()
	
	var new_image:Image = Image.new()
	var OK:int = new_image.load(image_path)
	if !(OK == 0):
		var temp_image:Image = Image.new()
		temp_image.create(15, 15, true, Image.FORMAT_RGB8)
		temp_image.fill(Color.DIM_GRAY)
		
		new_texture.create_from_image(temp_image) 
	else:
		new_image.resize(15, 15, Image.INTERPOLATE_NEAREST)
		new_texture.create_from_image(new_image) #,Texture2D.FLAGS_DEFAULT 
	
	return new_texture

# ------------------------------------------------------------------------------

# load texture
static func load_map_pin_texture(image_path:String) -> ImageTexture:
	var texture = ImageTexture.new()
	texture.create_from_image(load_image(image_path)) #,Texture2D.FLAG_FILTER
	texture.flags = Texture2D.FLAG_FILTER
	texture.storage = texture.STORAGE_COMPRESS_LOSSLESS
	return texture

# -------------------------------------------------------------------------------

# load image of specific size
static func load_texture_of_size(image_path:String, size:Vector2)->ImageTexture:
	var new_texture:ImageTexture = ImageTexture.new()
	
	var new_image:Image = Image.new()
	var OK:int = new_image.load(image_path)

	if !(OK == 0):
		var temp_image:Image = Image.new()
		temp_image.create(int(size.x), int(size.y), true, Image.FORMAT_RGB8)
		temp_image.fill(Color.DIM_GRAY)
		new_texture.create_from_image(temp_image) 
	else:
		new_image.resize(int(size.x), int(size.y), Image.INTERPOLATE_NEAREST)
		new_texture.create_from_image(new_image) #,Texture2D.FLAGS_DEFAULT
	
	return new_texture
