extends Control

signal map_layer_changed
# signal blend_mode_changed
# signal opacity_changed

onready var maps_manager_node:Node = get_owner().get_parent().get_owner().get_node("MapManager")
onready var maps_node:Control = get_owner().get_parent().get_owner().get_node("MapOrganise")

var layerNode:Control setget set_map_layer, get_map_layer 


func _ready():
	add_to_group('layer_option')


func set_layer_blend_mode(blend_mode:int)->void:
	maps_node.map.layers[layerNode.get_position_in_parent()].layer_shader = blend_mode
	layerNode.map_layer_node.material = MapLayer.fetch_shader_material(blend_mode, layerNode.map_layer_resources.layer_custom_shader)
	save_map()


func set_layer_opacity(opacity:float)->void:
	maps_node.map.layers[layerNode.get_position_in_parent()].layer_opacity = opacity
	layerNode.map_layer_node.modulate = Color(1.0, 1.0, 1.0, float(opacity)/100.00)
	save_map()


func set_layer_visibility(visiblity:bool)->void:
	maps_node.map.layers[layerNode.get_position_in_parent()].layer_visibility = visiblity
	layerNode.map_layer_node.visible  = visiblity
	save_map()

func set_map_layer(node:Control)->void:
	emit_signal("map_layer_changed")
	layerNode = node
	$VBoxContainer/HBoxContainer/OptionButton.selected = layerNode.map_layer_resources.layer_shader
	$VBoxContainer/HBoxContainer/SpinBox.value         = layerNode.map_layer_resources.layer_opacity


func get_map_layer()->Control:
	return layerNode


func save_map()->void:
	var _x = ResourceManager.SaveData.new(
		MapData.fetch_save_path().format({'uuid':maps_node.map.map_name}),
		maps_node.map
	)


func _on_OptionButton_item_selected(index)->void:
	set_layer_blend_mode(index)


func _on_SpinBox_value_changed(value):
	set_layer_opacity(value)
