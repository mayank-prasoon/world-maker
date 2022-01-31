extends Node

signal load_map(map_path)

# === Nodes ===

onready var items_node:OptionButton = $"../Camera2D/CanvasLayer/Menu/VBoxContainer/HBoxContainer/SideMenu/VBoxContainer/MapMenu/HBoxContainer/MenuButton"

# === variables ===

var map_list:Dictionary = {}

func _ready() -> void:
	load_maps_name()

# load maps
func load_maps_name() -> void:
	# clear item list
	items_node.items = []
	
	# add map name to the drop down list
	for maps_paths in SystemDataManager.mapSystem.get_maps():
		var map:Resource = load(maps_paths)
		map_list[map.map_name] = maps_paths
		items_node.add_item(map.map_name)
		

# create new map
func _on_MapCreator_generate_map(map_name:String, map_texture:String, map_chunk_size:Vector2)->void:
	var map_system:Node = SystemDataManager.mapSystem
	
	# generate new map
	map_system.generate_map(
		map_name,
		map_texture,
		map_chunk_size
	)

# select map from the dropdown
func _on_MenuButton_item_selected(index:int) -> void:
	var map_path:String = map_list[items_node.items[index]]
	emit_signal("load_map", map_path)
