extends Object

var comment_collection_node:Control = Control.new()
var inspector_node:Control          = Control.new()
var map_manager:Object              = null

# ------------------------------------------------------------------------------

# load the nodes where the comments will be stored
func _init(comment_node:Control, inspector:Control, map_manager:Object)->void:
	self.comment_collection_node = comment_node
	self.inspector_node          = inspector
	self.map_manager             = map_manager
	
	EventBus.connect("create_new_comment", self, "create_new_comment")
	EventBus.connect("remove_map_comment", self, 'remove_map_comment')
	
# ------------------------------------------------------------------------------

# create new comment
func create_new_comment(position, map_resource:MapData = self.map_manager.map_resource)->void:
	var uuid = UUID.generate()
	
	var map_comment = MapComment.new()
	var comment_scene:PackedScene = load("res://systems/map_system/ui_elements/map_comments/MapComment.tscn")
	var comment_node:Node2D       = comment_scene.instance()

	map_comment.comment_location   = position
	map_comment.comment_id         = uuid
	comment_node.comment_resource  = map_comment

	self.comment_collection_node.add_child(comment_node)

	map_resource.map_pins.append(map_comment)

	# create new map comment
	ResourceManager.SaveData.new(SystemDataManager.root_pin_save_path.format({"uuid":uuid}), map_comment)
	map_comment.set_path(SystemDataManager.root_pin_save_path.format({"uuid":uuid}))

	# emit signals
	EventBus.emit_signal("save_map", map_resource)
	EventBus.emit_signal("add_comment_inspector", map_comment, comment_node)
	EventBus.emit_signal("change_inspector_state", true)

# ------------------------------------------------------------------------------

# remove map pin
func remove_map_comment(resource_file:MapComment)->void:
	var position = map_manager.map_resource.map_pins.find(resource_file)
	map_manager.map_resource.map_pins.remove(position)

	EventBus.emit_signal("save_map", map_manager.map_resource)
	var resource_path = resource_file.get_path()

	# remove the resource file
	var dir = Directory.new()
	dir.remove(resource_path)
