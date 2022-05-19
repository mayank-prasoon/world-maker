extends VBoxContainer

# === NODE ===
onready var map_node:Control = get_owner()
onready var menu:Control      = $"../../../../../../../../.."

var create_layer:PackedScene   = preload("res://systems/map_system/ui_elements/layer_creator/LayerCreator.tscn")

func _on_Add_pressed()->void:
	create_layer()


func _on_Delete_pressed()->void:
	if !($LayersContainer/VBoxContainer.get_child_count() == 0):
		map_node.map_resource.layers.pop_at($LayerOptions.layerNode.get_position_in_parent())
		$LayerOptions.layerNode.queue_free()

		MapResourceSystem.MapResourceManager.save_map_resource(map_node.map_resource)


func create_layer()->void:
	var node = create_layer.instance()
	menu.add_child(node)


func _on_Edit_pressed()->void:
	var node = create_layer.instance()

	for layer_node in get_tree().get_nodes_in_group('map_layers'):
		if layer_node.selected:
			var layer:MapLayer = layer_node.map_layer_resources # resourece layer assigned to the Layer Node
			menu.add_child(node)
			node.edit_mode(layer, layer_node, layer_node.get_position_in_parent())
