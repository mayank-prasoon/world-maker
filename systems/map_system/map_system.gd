extends Control

# === NODES ===
onready var items_node:OptionButton      = $Camera2D/CanvasLayer/Menu/VBoxContainer/MapToolBar/HBoxContainer/MapSelectionMenu/HBoxContainer/MenuButton
onready var canvas_layer:CanvasLayer     = $Camera2D/CanvasLayer

onready var map_collection_node:Control  = $MapCollectionNode
onready var layer_container_node:Control = $Camera2D/CanvasLayer/Menu/VBoxContainer/HBoxContainer/SideMenu/VBoxContainer/Inspector/Panel/VboxContainer/MapLayers/VboxContainer/LayersContainer/VBoxContainer
onready var pin_collection_node:Control  = $PinCollectionNode

onready var inspector_node:Control       = $Camera2D/CanvasLayer/Menu/VBoxContainer/HBoxContainer/SideMenu/VBoxContainer/Inspector
onready var camera_node:Camera2D         = $Camera2D
# === EXPORTS ===


# === SIGNALS ===
#signal load_map(map_path)
signal toggle_map_pin_manger(state)

# === VAR(s) ===

var map_resource:MapData = MapData.new()

# create MapLoadSystem object to handle loading and unloading
onready var map_load_system:MapLoadSystem   = MapLoadSystem.new(items_node)

# load and remove map texture node  
onready var map_manager:MapManager          = MapManager.new(self, pin_collection_node, map_collection_node, camera_node)

# add and remove map layer node
onready var map_layer_system:MapLayerSystem = MapLayerSystem.new(map_collection_node, layer_container_node, map_resource)

# add map pins to the map
onready var map_pin_system:MapPinSystem     = MapPinSystem.new(pin_collection_node, inspector_node)

# === INTERNAL CLASS(s) ===

# load map and add them to list
class MapLoadSystem extends Object:
	var map_list:Dictionary      = {}
	var option_node:OptionButton = OptionButton.new()
	var current_selected_map     = 0
	
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

# add or remove map texture node
class MapManager extends Object:
	signal create_layers(map_path)
	
	var add_map_thread:Thread
	var add_pin_thread:Thread
	
	# === VAR(s) ===
	var map_resource:MapData     = MapData.new()
	var map_resource_path:String = ""
	var camera_node:Camera2D     = Camera2D.new()
	var map_node:Control         = Control.new()
	var pin_node:Control         = Control.new()
	var node:Control             = Control.new()

	# initialize node
	func _init(node:Control, pin_node:Control, map_node:Control, camera_node:Camera2D):
		self.node         = node
		self.map_node     = map_node
		self.pin_node     = pin_node
		self.camera_node  = camera_node
		
		var x = self.connect("create_layers", node, 'assign_layers')

	# map manager laod map method
	func load_map_texture(resource_path:String) -> void:
		self.map_resource_path = resource_path
		map_resource = load(resource_path)

		# display map
		add_map_thread = Thread.new()
		add_pin_thread = Thread.new()

		var _x = add_map_thread.start(self, 'create_map_texture_node')
		var _y = add_pin_thread.start(self, 'add_map_pins')
	#	create_map_texture_node()

	# join thread
	func join_thread()->void:
		add_map_thread.wait_to_finish()
		add_pin_thread.wait_to_finish()


	# create map texture map_name
	func create_map_texture_node(_x: = null)->void:
		remove_nodes()
		assign_texture()


	# display entire map
	# NOTE: this only for testing purposes
	func remove_nodes() -> void:
		for x in self.map_node.get_children():
			x.queue_free()


	func add_map_pins(_x = null) -> void:
		for x in self.pin_node.get_children():
			x.queue_free()

		var map_pin_scene:PackedScene = load("res://systems/map_system/ui_elements/map_pin/MapPin.tscn")

		for pin_resource in self.map_resource.map_pins:
			var map_pin_node = map_pin_scene.instance()
			map_pin_node.pin_resource = pin_resource
			pin_node.call_deferred("add_child", map_pin_node)


	func assign_texture() -> void:
		var texture = TextureRect.new()
		texture.texture = ImageHandler.load_image_texture(map_resource.image_path)
		texture.mouse_filter = Control.MOUSE_FILTER_IGNORE
		camera_node.setup_camera_for_map(texture.texture.get_size()/2, texture.texture.get_size())

		map_node.call_deferred("add_child", texture)
		self.call_deferred('join_thread')
		self.call_deferred('emit_signal', "create_layers", map_resource_path)

# manage the layer
class MapLayerSystem extends Object:

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
			# create layer node and texture and assign them

		else: # check if the index is not -1
			map_resource.layers[index] = map_layer_resource

			# remove layer
			map_texture_node_container.get_children()[index].queue_free()
			map_texture_node_container.get_children()[index].queue_free()

		create_layer_node(map_layer_resource)

		# save the resource file
		MapResourceSystem.MapResourceManager.save_map_resource(map_resource)


	func save_layer(map_layer_resource:MapLayer, index:int)->void:
		map_resource.layers[index] = map_layer_resource
		
		MapResourceSystem.MapResourceManager.save_map_resource(map_resource)

	# assign layer
	func assign_layers()->void:
		for node in layer_container_node.get_children():
			node.queue_free()

		for map_layer in map_resource.layers:
			create_layer_node(map_layer)


	# create the layer node and the layer texture node
	func create_layer_node(map_layer_resource:MapLayer)-> void:

		# create texture node
		var texture = TextureRect.new()
		texture.texture = ImageHandler.load_image_texture(map_layer_resource.layer_path)
		texture.mouse_filter = Control.MOUSE_FILTER_IGNORE
		map_texture_node_container.call_deferred("add_child", texture)

		# create layer node
		var layer_node:Control = load("res://systems/map_system/ui_elements/map_layers/Layers.tscn").instance()
		layer_node.texture_node             = texture
		layer_node.map_layer_resources      = map_layer_resource

		layer_container_node.add_child(layer_node)
		layer_node.rect_size      = Vector2(272, 30)

# manage pin
	
class MapPinSystem extends Object:
	var pin_collection_node:Control = Control.new()
	var inspector_node:Control      = Control.new()


	func _init(pin_node:Control, inspector:Control):
		self.pin_collection_node = pin_node
		self.inspector_node      = inspector


	func add_pin(position, map_resource:MapData)->void:
		var uuid = UUID.generate()
		
		var map_pin = MapPin.new()
		var pin_scene:PackedScene = load("res://systems/map_system/ui_elements/map_pin/MapPin.tscn")
		var pin_node:Node2D       = pin_scene.instance()

		map_pin.pin_location      = position
		map_pin.pin_id            = uuid
		pin_node.pin_resource     = map_pin

		self.pin_collection_node.add_child(pin_node)
		
		create_new_pin(map_resource, map_pin, uuid)
		EventBus.emit_signal("change_inspector_state", true)
		inspector_node.add_map_pin_inspector(map_pin, pin_node)


	func create_new_pin(map_resource, map_pin, uuid)->void:
		map_resource.map_pins.append(map_pin)
		ResourceManager.SaveData.new(SystemDataManager.root_pin_save_path.format({"uuid":uuid}), map_pin)
		
		map_pin.set_path(SystemDataManager.root_pin_save_path.format({"uuid":uuid}))

		EventBus.emit_signal("save_map", map_resource)



#                                === METHODS ===
# ------------------------------------------------------------------------------

func _ready()->void:
	var _x = EventBus.connect("save_map", self, '_on_save_map')
	var _y = EventBus.connect("create_new_map", self, '_on_create_new_map')
	var _z = EventBus.connect("add_pin_to_map", self, '_on_add_pin_to_map')
	var _p = EventBus.connect("save_map_layer", self, '_on_save_map_layer')
	var _q = EventBus.connect("remove_map_pin", self, '_on_remove_map_pin')
	var _r = EventBus.connect("move_pin_to_top", self, '_on_move_pin_to_top')
	var _s = EventBus.connect("delete_current_map", self, '_on_current_delete_map')
	
	var _t = items_node.connect("item_selected", self, '_on_MenuButton_item_selected')
	
	map_load_system.assign_map_name()


# save map
func _on_save_map(map_resource)->void:
	MapResourceSystem.MapResourceManager.save_map_resource(map_resource)

# ------------------------------------------------------------------------------

# create map layer
func create_layer(resource, index)->void:
	map_layer_system.create_layer(resource, index)

# save map layer
func _on_save_map_layer(layers:MapLayer, index)->void:
	map_layer_system.save_layer(layers, index)

# ------------------------------------------------------------------------------

# remove map pin
func _on_remove_map_pin(resource_file:MapPin)->void:
	var position = map_resource.map_pins.find(resource_file)
	map_resource.map_pins.remove(position)

	EventBus.emit_signal("save_map", map_resource)
	var resource_path = resource_file.get_path()

	# remove the resource file
	var dir = Directory.new()
	dir.remove(resource_path)


# ------------------------------------------------------------------------------

func _on_move_pin_to_top(map_pin)->void:
	 $PinCollectionNode.move_child(map_pin, $PinCollectionNode.get_child_count())


#                               === SIGNALS ===
# ------------------------------------------------------------------------------

# when map menu is clicked
func _on_MenuButton_item_selected(index)->void:
	if (index != -1):
		$Camera2D/LoadingLayer/ColorRect/AnimationPlayer.play("RESET")
		$Camera2D/LoadingLayer/ColorRect/AnimationPlayer.play("close")
		var map_resource_path:String = map_load_system.map_list.values()[index]
		map_manager.load_map_texture(map_resource_path)
		map_load_system.current_selected_map = index

# when layer are requested to assigned
func assign_layers(map_resource_path:String)->void:
	map_resource = load(map_resource_path)
	map_layer_system.map_resource = map_resource
	map_layer_system.assign_layers()

# when a map creater requests to genrate a map 
func _on_create_new_map(map_name:String, map_texture:String, article:bool)->void:
	MapResourceSystem.MapResourceManager.create_map_resource(map_name, map_texture, article)
	map_load_system.assign_map_name()
	items_node.emit_signal("item_selected", -1)
	

# when a pin is requested to be added
func _on_add_pin_to_map(position):
	map_pin_system.add_pin(position, map_resource)
	EventBus.emit_signal("save_map", map_resource)

# ------------------------------------------------------------------------------

# delete map
func _on_current_delete_map()->void:
	$Camera2D/LoadingLayer/ColorRect/AnimationPlayer.play("RESET")
	$Camera2D/LoadingLayer/ColorRect/AnimationPlayer.play("close")
	
	var map_resource_path:String = map_load_system.map_list.values()[map_load_system.current_selected_map]
	var dir = Directory.new()
	dir.remove(map_resource_path)
	items_node.remove_item(map_load_system.current_selected_map)
	
	items_node.emit_signal("item_selected", 0)
	

# run on exiting the node tree
func _exit_tree()->void:
	map_load_system.free()
	map_manager.free()
	map_layer_system.free()


func _on_Button_toggled(button_pressed):
	emit_signal("toggle_map_pin_manger", button_pressed)
