extends Object

var map_texture_node_container:Control = Control.new()
var layer_container_node:VBoxContainer = VBoxContainer.new()
var map_manger:Object                  = null

# ------------------------------------------------------------------------------

# initialize
func _init(map_node:Control, layer_node:VBoxContainer, map_manager:Object):
	self.map_texture_node_container = map_node
	self.layer_container_node       = layer_node
	self.map_manger                 = map_manager
	
	# connect signals
	var _a = EventBus.connect("create_new_layer",  self, 'create_layer')
	var _b = EventBus.connect("save_map_layer", self, 'save_layer')
	var _c = EventBus.connect("assign_layer", self, 'assign_layers')

# ------------------------------------------------------------------------------

# create new layer
func create_layer(map_layer_resource:MapLayer, index:int)->void:
	if index == -1: # check if the index is -1
		self.map_manger.map_resource.layers.append(map_layer_resource)
		# create layer node and texture and assign them

	else: # check if the index is not -1
		self.map_manger.map_resource.layers[index] = map_layer_resource

		# remove layer
		map_texture_node_container.get_children()[index].queue_free()
		map_texture_node_container.get_children()[index].queue_free()

	create_layer_node(map_layer_resource)

	# save the resource file
	MapResourceSystem.MapResourceManager.save_map_resource(self.map_manger.map_resource)

# ------------------------------------------------------------------------------

# save map layer
func save_layer(map_layer_resource:MapLayer, index:int)->void:
	if self.map_manger.map_resource.layers.size() > index:
		self.map_manger.map_resource.layers[index] = map_layer_resource
		
		MapResourceSystem.MapResourceManager.save_map_resource(self.map_manger.map_resource)

# ------------------------------------------------------------------------------

# assign layer
func assign_layers(map_resource:MapData)->void:
	for node in layer_container_node.get_children():
		node.queue_free()

	for map_layer in map_resource.layers:
		create_layer_node(map_layer)

# ------------------------------------------------------------------------------

# create the layer node and the layer texture node
func create_layer_node(map_layer_resource:MapLayer)-> void:

	# create texture node
	var texture = TextureRect.new()
	texture.texture      = ImageHandler.load_image_texture(map_layer_resource.layer_path)
	texture.mouse_filter = Control.MOUSE_FILTER_IGNORE
	map_texture_node_container.call_deferred("add_child", texture)

	# create layer node
	var layer_node:Control = load("res://systems/map_system/ui_elements/map_layers/Layers.tscn").instance()
	layer_node.texture_node             = texture
	layer_node.map_layer_resources      = map_layer_resource

	layer_container_node.add_child(layer_node)
	layer_node.rect_size      = Vector2(272, 30)
