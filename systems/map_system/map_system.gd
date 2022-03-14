extends Control

# === NODES ===
onready var items_node:OptionButton  = $Camera2D/CanvasLayer/Menu/VBoxContainer/HBoxContainer/SideMenu/VBoxContainer/MapMenu/HBoxContainer/MenuButton
onready var canvas_layer:CanvasLayer = $Camera2D/CanvasLayer
onready var map_collection_node:Control         = $MapCollectionNode
onready var layer_container_node:Control  = $"Camera2D/CanvasLayer/Menu/VBoxContainer/HBoxContainer/SideMenu/VBoxContainer/Inspector/Panel/TabContainer/Map Layers/LayersContainer/VBoxContainer"

# === EXPORTS ===
export(Resource) var map_resource:Resource = MapData.new()


# === SIGNALS ===
#signal load_map(map_path)

# === VAR(s) ===

# create MapLoadSystem object to handle loading and unloading
onready var map_load_system:MapLoadSystem   = MapLoadSystem.new(items_node)

# load and remove map texture node  
onready var map_manager:MapManager          = MapManager.new(map_collection_node)

# add and remove map layer node
onready var map_layer_system:MapLayerSystem = MapLayerSystem.new(map_collection_node, layer_container_node, map_resource)

# === INTERNAL CLASS(s) ===


# load map and add them to list
class MapLoadSystem extends Object:
	var map_list:Dictionary      = {}
	var option_node:OptionButton = OptionButton.new()
	
	func _init(node:OptionButton):
		option_node = node
	
	# load maps
	func assign_map_name() -> void:
		
		# clear item list
		option_node.items = []

		var maps_paths = MapSystem.get_maps()

		# add map name to the drop down list
		for maps_resource_path in maps_paths:
			var map:Resource = load(maps_resource_path)
			map_list[map.map_name] = maps_resource_path
			option_node.add_item(map.map_name)
		
		# emit the item selected signal
		option_node.emit_signal("item_selected", option_node.selected)


# save map resource file
class MapSaveSystem extends Reference:
	# create new map
	static func generate_map(map_name:String, map_texture:String, article:bool)->void:
		# instance and add the loading scene to the scene	
		
		ResourceManager.save_file(
			{
				"map_name"     : map_name,
				"image_path"   : map_texture,
				"tags"         : [],
			},

			ResourceManager.MAP
		)

		if article: # if article needs to be generated
			ResourceManager.save_file(
				{
					'article_name'        : map_name,
					'article_id'          : UUID.generate(),
					'article_resources'   : ResourceManager.resource_path(ResourceManager.MAP).format({'uuid':map_name})
				},
				
				ResourceManager.ARTICLE
			)
	
	# saves map
	static func save_map(map_name:String, map_texture:String, map_layer:Array, map_pin:Array, tags:Array)->void:
		ResourceManager.save_file(
			{
				"map_name"     : map_name,
				"image_path"   : map_texture,
				"map_pins"     : map_pin,
				"map_size"     : Vector2(0,0), # depricated and need to be removed
				"layers"       : map_layer,
				"tags"         : tags
			},

			ResourceManager.MAP
		)


# add or remove map texture node
class MapManager extends Object:
	var thread:Thread
	
	# === VAR(s) ===
	var map_resource:MapData = MapData.new()
	var node:Control         = Control.new() 


	# initialize node
	func _init(new_node:Control):
		self.node         = node


	# map manager laod map method
	func load_map_texture(resource_path:String) -> void:
		map_resource = load(resource_path)

		# display map
		thread = Thread.new()
		var _x = thread.start(self, 'create_map_texture_node')


	# join thread
	func join_thread()->void:
		thread.wait_to_finish()


	# create map texture node
	func create_map_texture_node(_x: = null)->void:
		remove_nodes()
		assign_texture()


	# display entire map
	# NOTE: this only for testing purposes
	func remove_nodes() -> void:
		for x in self.node.get_children():
			x.queue_free()
		
	func assign_texture() -> void:
		var texture = TextureRect.new()
		texture.texture = ImageHandler.load_image_texture(map_resource.image_path)
		texture.mouse_filter = Control.MOUSE_FILTER_IGNORE
		node.get_parent().get_node("Camera2D").setup_camera_for_map(texture.texture.get_size()/2)

		self.node.call_deferred("add_child", texture)
		self.call_deferred('join_thread')


# manage the layer
class MapLayerSystem extends Reference:

	var map_texture_node_container:Control = Control.new()
	var layer_container_node:VBoxContainer = VBoxContainer.new()
	var map_resource:MapData               = MapData.new()

	# initialize
	func _init(map_node:Control, layer_node:VBoxContainer, resource:Resource):
		self.map_texture_node_container = map_node
		self.layer_container_node       = layer_node
		self.map_resource               = resource


	# create new layer
	func create_layer(map_layer_resource:MapLayer, index:int)->void:
		if index == -1: # check if the index is -1
			map_resource.layers.append(map_layer_resource)
		else: # check if the index is not -1
			map_resource.layers[index] = map_layer_resource

			# remove layer
			map_texture_node_container.get_children()[index].queue_free()
			map_texture_node_container.get_children()[index].queue_free()

		# create layer node and texture and assign them
		create_layer_node(map_layer_resource)

		# save the resource file
		MapSaveSystem.save_map(
			map_resource.map_name,
			map_resource.image_path,
			map_resource.layers,
			map_resource.map_pins,
			map_resource.tags
		)


	# assign layer
	func assign_layers()->void:
		for node in layer_container_node.get_children():
			node.queue_free()

		for map_layer in map_resource.layers:
			create_layer_node(map_layer)


	# create the layer node
	func create_layer_node(map_layer_resource:MapLayer)-> void:

		# create texture node
		var texture = TextureRect.new()
		texture.texture = ImageHandler.load_image_texture(map_layer_resource.layer_path)
		texture.mouse_filter = Control.MOUSE_FILTER_IGNORE
		map_texture_node_container.call_deferred("add_child", texture)

		# create layer node
		var layer_node:Control = load("res://systems/map_system/ui_elements/map_layers/Layers.tscn").instance()
		layer_node.map_layer_node           = texture
		layer_node.map_layer_resources      = map_layer_resource
		
		layer_container_node.add_child(layer_node)
		layer_node.rect_size      = Vector2(272, 30)


# === METHODS ===


func _ready()->void:
	map_load_system.assign_map_name()


func _on_MenuButton_item_selected(index):
	if (index != -1):
		var map_resource_path:String = map_load_system.map_list.values()[index]
		map_manager.load_map_texture(map_resource_path)

		map_resource = load(map_resource_path)
		assign_layers(map_resource)


func assign_layers(resource:MapData)->void:
	map_layer_system.map_resource = resource
	map_layer_system.assign_layers()


func _on_MapCreator_generate_map(map_name:String, map_texture:String, article:bool)->void:
	MapSaveSystem.generate_map(map_name, map_texture, article)

# run on exiting the node tree
func _exit_tree():
	map_load_system.free()
	map_manager.free()
	map_layer_system.free()
