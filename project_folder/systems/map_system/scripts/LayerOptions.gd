extends Control

signal map_layer_changed
# signal blend_mode_changed
# signal opacity_changed

var layerNode:Control : get = get_map_layer, set = set_map_layer 


func _ready():
	add_to_group('layer_option')


func set_layer_blend_mode(blend_mode:int)->void:
	layerNode.set_layer_blend_mode(blend_mode)


func set_layer_opacity(opacity:float)->void:
	layerNode.set_layer_opacity(opacity)


func set_layer_visibility(visiblity:bool)->void:
	layerNode.set_layer_visibility(visiblity)


func set_map_layer(node:Control)->void:
	emit_signal("map_layer_changed")
	layerNode = node
	$VBoxContainer/HBoxContainer/OptionButton.selected = layerNode.map_layer_resources.layer_shader
	$VBoxContainer/HBoxContainer/SpinBox.value         = layerNode.map_layer_resources.layer_opacity


func get_map_layer()->Control:
	return layerNode


func _on_OptionButton_item_selected(index)->void:
	set_layer_blend_mode(index)


func _on_SpinBox_value_changed(value):
	set_layer_opacity(value)
