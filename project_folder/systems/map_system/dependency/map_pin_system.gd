extends Object

var pin_collection_node:Control = Control.new()
var inspector_node:Control      = Control.new()
var map_manager:Object          = null

# ------------------------------------------------------------------------------

# initialize
func _init(pin_node:Control,inspector:Control,map_manager:Object):
	self.pin_collection_node = pin_node
	self.inspector_node      = inspector
	self.map_manager         = map_manager

	EventBus.connect("create_new_pin",Callable(self,"create_new_pin"))
	EventBus.connect("remove_map_pin",Callable(self,'remove_map_pin'))
	EventBus.connect("move_pin_to_top",Callable(self,'move_pin_to_top'))

# ------------------------------------------------------------------------------

# create new pin for the map
func create_new_pin(position:Vector2, map_resource:MapData = self.map_manager.map_resource)->void:
	var uuid = UUID.generate()
	
	var map_pin = MapPin.new()
	var pin_scene:PackedScene = load("res://systems/map_system/ui_elements/map_pin/MapPin.tscn")
	var pin_node:Node2D       = pin_scene.instantiate()

	map_pin.pin_location      = position
	map_pin.pin_id            = uuid
	pin_node.pin_resource     = map_pin

	self.pin_collection_node.add_child(pin_node)
	
	map_resource.map_pins.append(map_pin)
	ResourceManager.SaveData.new(SystemDataManager.root_pin_save_path.format({"uuid":uuid}), map_pin)

	map_pin.set_path(SystemDataManager.root_pin_save_path.format({"uuid":uuid}))

	EventBus.emit_signal("save_map", map_resource)
	EventBus.emit_signal("change_inspector_state", true)
	inspector_node.add_map_pin_inspector(map_pin, pin_node)

# ------------------------------------------------------------------------------

# remove map pin
func remove_map_pin(resource_file:MapPin)->void:
	var position = map_manager.map_resource.map_pins.find(resource_file)
	map_manager.map_resource.map_pins.remove(position)

	EventBus.emit_signal("save_map", map_manager.map_resource)
	var resource_path = resource_file.get_path()

	# remove the resource file
	var dir = Directory.new()
	dir.remove(resource_path)

# ------------------------------------------------------------------------------

# move pin to top of the map
func move_pin_to_top(map_pin)->void:
	 self.pin_collection_node.move_child(map_pin, self.pin_collection_node.get_child_count())
