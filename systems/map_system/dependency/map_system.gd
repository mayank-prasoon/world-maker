extends Object


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
			var map:MapData = load(maps_resource_path)
			if !(map == null):
				map_list[map.map_name] = maps_resource_path
				option_node.add_item(map.map_name)
		
		# emit the item selected signal
		option_node.emit_signal("item_selected", option_node.selected)

# ------------------------------------------------------------------------------

# add or remove map texture node
class MapManager extends Object:
	# === THREAD(s) ===
	var add_map_thread:Thread
	var add_pin_thread:Thread
	var add_comment_thread:Thread
	
	# === VAR(s) ===
	var map_resource:MapData           = MapData.new()
	var map_resource_path:String       = ""
	
	# === NODE(s) ===
	var camera_node:Camera2D           = Camera2D.new()
	var map_container_node:Control     = Control.new()
	var pin_container_node:Control     = Control.new()
	var comment_container_node:Control = Container.new()
	var map_layer_system:Object        = null

	# initialize object
	func _init(pin_node:Control, comment_node:Control, map_node:Control, camera_node:Camera2D)->void:
		self.map_layer_system       = map_layer_system
		self.map_container_node     = map_node
		self.pin_container_node     = pin_node
		self.comment_container_node = comment_node
		self.camera_node            = camera_node

	# map manager laod map method
	func load_map_texture(resource_path:String) -> void:
		self.map_resource_path = resource_path
		map_resource = load(resource_path)

		# display map
		add_map_thread     = Thread.new()
		add_pin_thread     = Thread.new()
		add_comment_thread = Thread.new()
		
		var _x = add_map_thread.start(self, 'create_map_texture_node')
		var _y = add_pin_thread.start(self, 'add_map_pins')
		var _z = add_comment_thread.start(self, 'add_map_comments')

	# join thread
	func join_thread()->void:
		add_map_thread.wait_to_finish()
		add_pin_thread.wait_to_finish()
		add_comment_thread.wait_to_finish()


	# create map texture map_name
	func create_map_texture_node(_x: = null)->void:
		remove_nodes()
		assign_texture()


	# display entire map
	# NOTE: this only for testing purposes
	func remove_nodes() -> void:
		for x in self.map_container_node.get_children():
			x.queue_free()

	
	# add map pin to the map pin collection node
	func add_map_pins(_x = null) -> void:
		for x in self.pin_container_node.get_children():
			x.queue_free()

		var map_pin_scene:PackedScene = load("res://systems/map_system/ui_elements/map_pin/MapPin.tscn")

		for resource in self.map_resource.map_pins:
			if resource is MapPin: 
				var map_pin_node = map_pin_scene.instance()
				map_pin_node.pin_resource = resource
				pin_container_node.call_deferred("add_child", map_pin_node)

	# add map comments to map comment collection node
	func add_map_comments(_x = null) ->void:
		for x in self.comment_container_node.get_children():
			x.queue_free()

		var map_comment_scene:PackedScene = load("res://systems/map_system/ui_elements/map_comments/MapComment.tscn")

		for resource in self.map_resource.map_pins:
			if resource is MapComment:
				var map_comment_node = map_comment_scene.instance()
				map_comment_node.comment_resource = resource
				comment_container_node.call_deferred("add_child", map_comment_node)

	# assign texture
	func assign_texture() -> void:
		var texture = TextureRect.new()
		texture.texture = ImageHandler.load_image_texture(map_resource.image_path)
		texture.mouse_filter = Control.MOUSE_FILTER_IGNORE
		camera_node.setup_camera_for_map(texture.texture.get_size()/2, texture.texture.get_size())

		map_container_node.call_deferred("add_child", texture)
		self.call_deferred('join_thread')
		EventBus.emit_signal("assign_layer", self.map_resource)


# == initialize ==
func _init():
	EventBus.connect("save_map", self, '_on_save_map')
	EventBus.connect("create_new_map", self, '_on_create_new_map')

# saves map
func _on_save_map(map_resource:MapData)->void:
	MapResourceSystem.MapResourceManager.save_map_resource(map_resource)


# create new map
func _on_create_new_map(map_name:String, map_texture:String, article:bool)->void:
	MapResourceSystem.MapResourceManager.create_map_resource(map_name, map_texture, article)
	EventBus.emit_signal("reload_system")
