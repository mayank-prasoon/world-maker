extends Control

signal toggle_map_pin_manger(button_state)

# === NODE(s) ===
onready var map_texture_collection_node  = $MapCollectionNode
onready var comment_collection_node      = $CommentCollectionNode
onready var pin_collection_node          = $PinCollectionNode
onready var inspector                    = $Camera2D/CanvasLayer/Menu/VBoxContainer/HBoxContainer/SideMenu/VBoxContainer/Inspector
onready var map_layer_button_cantainer   = $Camera2D/CanvasLayer/Menu/VBoxContainer/HBoxContainer/SideMenu/VBoxContainer/Inspector/Panel/VboxContainer/MapLayers/VboxContainer/LayersContainer/VBoxContainer
onready var camera_node                  = $Camera2D
onready var map_selection_node           = $Camera2D/CanvasLayer/Menu/VBoxContainer/MapToolBar/HBoxContainer/MapSelectionMenu/HBoxContainer/MenuButton

# === objects ===

# map system related
onready var map_system:Object     = preload("res://systems/map_system/dependency/map_system.gd").new()
onready var map_loader:Object     = map_system.MapLoadSystem.new(map_selection_node)
onready var map_manager:Object    = map_system.MapManager.new(pin_collection_node, comment_collection_node, map_texture_collection_node, camera_node)

onready var comment_system:Object = preload("res://systems/map_system/dependency/map_comment_system.gd").new(comment_collection_node, inspector, map_manager)
onready var pin_system:Object     = preload("res://systems/map_system/dependency/map_pin_system.gd").new(pin_collection_node, inspector, map_manager)
onready var layer_system:Object   = preload("res://systems/map_system/dependency/map_layer_system.gd").new(map_texture_collection_node, map_layer_button_cantainer, map_manager)

# === METHOD(s) ===

# initialize
func _init()->void:
	EventBus.connect("reload_system", self, 'reload_system')
	EventBus.connect("change_map_to", self, '_on_change_map_to')
	EventBus.connect("delete_current_map", self, '_on_current_delete_map')

func _ready()->void:
	map_loader.assign_map_name()

# ------------------------------------------------------------------------------

# reload map the entire system
func reload_system()->void:
	get_parent().add_child(load("res://systems/map_system/MapSystem.tscn").instance())
	self.queue_free()

# ------------------------------------------------------------------------------

# delete map
func _on_current_delete_map()->void:
	$Camera2D/LoadingLayer/ColorRect/AnimationPlayer.play("RESET")
	$Camera2D/LoadingLayer/ColorRect/AnimationPlayer.play("close")
	
	var map_resource_path:String = map_loader.map_list.values()[map_loader.current_selected_map]
	var dir = Directory.new()
	dir.remove(map_resource_path)
	map_selection_node.remove_item(map_loader.current_selected_map)
	reload_system()
	


# ---------------------------------------------------------------------------- #
#                                   SIGNALS                                    #
# ---------------------------------------------------------------------------- #


# when map menu is clicked
func _on_MenuButton_item_selected(index)->void:
	if (index != -1):
		$Camera2D/LoadingLayer/ColorRect/AnimationPlayer.play("RESET")
		$Camera2D/LoadingLayer/ColorRect/AnimationPlayer.play("close")
		var map_resource_path:String = map_loader.map_list.values()[index]
		map_manager.map_resource = load(map_resource_path)
		map_manager.load_map_texture(map_resource_path)
		map_loader.current_selected_map = index
		EventBus.emit_signal("clear_inspector")

# ------------------------------------------------------------------------------

# change map to different map
func _on_change_map_to(map_data:MapData)->void:
	if !(map_data == null):
		var get_path  = map_data.get_path()
		var map_index = map_loader.map_list.values().find(get_path)
		_on_MenuButton_item_selected(map_index)
		$Camera2D/CanvasLayer/Menu/VBoxContainer/MapToolBar/HBoxContainer/MapSelectionMenu/HBoxContainer/MenuButton.selected = map_index
	else:
		pass

# ------------------------------------------------------------------------------

# toggle map pin manager signal receiver
func _on_Button_toggled(button_pressed):
	emit_signal("toggle_map_pin_manger", button_pressed)

# ------------------------------------------------------------------------------

# free the object on node exiting the tree
func _exit_tree()->void:
	# map system
	map_manager.free()
	map_loader.free()
	map_system.free()
	
	layer_system.free()   # layer system related
	pin_system.free()     # pin system related
	comment_system.free() # comment system related
