extends VBoxContainer

# === NODE ===
onready var maps_node:Control = get_owner().get_parent().get_owner().get_node("MapOrganise")
onready var menu:Control      = $"../../../../../../../.."

var create_layer:PackedScene   = preload("res://systems/map_system/ui_elements/layer_creator/LayerCreator.tscn")

func _on_Add_pressed():
	create_layer()


func _on_Delete_pressed():
	maps_node.map.layers.pop_at($LayerOptions.layerNode.get_position())
	$LayerOptions.layerNode.queue_free()


func create_layer()->void:
	var node = create_layer.instance()
	menu.add_child(node)


func _on_Edit_pressed():
	var node = create_layer.instance()
	
	for layer_node in get_tree().get_nodes_in_group('map_layers'):
		if layer_node.selected:
			var layer:MapLayer = layer_node.map_layer_resources # resourece layer assigned to the Layer Node
			menu.add_child(node)
			node.edit_mode(layer, layer_node, layer_node.get_position_in_parent())
