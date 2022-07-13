extends Node

signal load_map(map_path)

# === Nodes ===

onready var items_node:OptionButton  = $"../Camera2D/CanvasLayer/Menu/VBoxContainer/HBoxContainer/SideMenu/VBoxContainer/MapMenu/HBoxContainer/MenuButton"
onready var canvas_layer:CanvasLayer = get_parent().get_node("Camera2D/CanvasLayer")

# === variables ===

var map_list:Dictionary = {}


func _ready() -> void:
	load_maps_name()


# load maps
func load_maps_name() -> void:
	
	# clear item list
	items_node.items = []
	
	var maps_paths = MapSystem.get_maps()

	# add map name to the drop down list
	for maps_path in maps_paths:
		var map:Resource = load(maps_path)
		map_list[map.map_name] = maps_path
		items_node.add_item(map.map_name)

	items_node.emit_signal("item_selected", items_node.selected)


# create new map
func _on_MapCreator_generate_map(map_name:String, map_texture:String, article:bool)->void:
	# instance and add the loading scene to the scene	
	
	ResourceManager.save_file(
		{
			"map_name"     : map_name,
			"image_path"   : map_texture,
			"tags"         : [],
		},

		ResourceManager.MAP
	)

	if article:
		ResourceManager.save_file(
			{
				'article_name'        : map_name,
				'article_id'          : UUID.generate(),
				'article_resources'   : ResourceManager.resource_path(ResourceManager.MAP).format({'uuid':map_name})
			},
			
			ResourceManager.ARTICLE
		)

	load_maps_name()

func save_map(map_name:String, map_texture:String, map_layer:Array, map_pin:Array, tags:Array)->void:
	ResourceManager.save_file(
		{
			"map_name"     : map_name,
			"image_path"   : map_texture,
			"tags"         : tags,
			"map_pins"     : map_pin,
			"layers"       : map_layer
		},

		ResourceManager.MAP
	)

# select map from the dropdown
func _on_MenuButton_item_selected(index:int) -> void:
	if (index != -1):
		var map_path:String = map_list.values()[index]
		emit_signal("load_map", map_path)


# depricated
func _on_MenuButton_item_focused(index):
	load_maps_name()
