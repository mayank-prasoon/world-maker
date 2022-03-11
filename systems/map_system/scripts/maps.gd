extends Control

var thread:Thread

# === NODES ===
onready var layers = $"../Camera2D/CanvasLayer/Menu/VBoxContainer/HBoxContainer/SideMenu/VBoxContainer/Inspector/Panel/TabContainer/Map Layers/Panel/Layers"
onready var map_manager = $"../MapManager"

# === VARIABLES ===
var map:MapData


func _ready()->void:
	self.focus_mode = Control.FOCUS_ALL

# map manager laod map method
func _on_MapManager_load_map(map_path:String) -> void:
	# load map
	map    = load(map_path)

	# display map
	thread = Thread.new()
	var _x = thread.start(self, 'display_entire_map')

#join thread
func join_thread()->void:
	thread.wait_to_finish()

# display entire map
# NOTE: this only for testing purposes
func display_entire_map(_x = null) -> void:
	for x in self.get_children():
		x.queue_free()
	
	
	var texture = TextureRect.new()
	texture.texture = ImageHandler.load_image_texture(map.image_path)
	texture.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$"../Camera2D".setup_camera_for_map(texture.texture.get_size()/2)

	self.call_deferred("add_child", texture)
	self.call_deferred('join_thread')
	self.call_deferred('assign_layers')


func create_layer(map_layer_resource:MapLayer, index:int)->void:
	if index == -1: # check if the index is -1
		map.layers.append(map_layer_resource)
	else: # check if the index is not -1
		map.layers[index] = map_layer_resource

		# remove layer
		layers.get_children()[index].queue_free()
		self.get_children()[index].queue_free()
	
	# create layer node and texture and assign them
	create_layer_node(map_layer_resource)

	map_manager.save_map(
		map.map_name,
		map.image_path,
		map.layers,
		map.map_pins,
		map.tags
	)


func assign_layers()->void:
	for node in layers.get_children():
		node.queue_free()

	for map_layer in map.layers:
		create_layer_node(map_layer)

# create the layer node
func create_layer_node(map_layer_resource)-> void:

	# create texture node
	var texture = TextureRect.new()
	texture.texture = ImageHandler.load_image_texture(map_layer_resource.layer_path)
	texture.mouse_filter = Control.MOUSE_FILTER_IGNORE
	self.call_deferred("add_child", texture)

	# create layer node
	var layer_node:Control = load("res://systems/map_system/ui_elements/map_layers/Layers.tscn").instance()
	layer_node.map_layer_node           = texture
	layer_node.map_layer_resources      = map_layer_resource
	
	layers.add_child(layer_node)
	layer_node.rect_size      = Vector2(272, 30)
