extends Node

onready var root_node:Node   = self.get_parent().get_parent()
onready var save_system:Node = self.get_parent().get_node("SaveSystem")

func get_tags(map_name:String) -> Array:
	var _temp_pin_resource:Resource     = save_system.open_file(map_name)
	var tags:Array                      = _temp_pin_resource.tags
	return tags

func get_layers(map_name:String) -> Array:
	var _temp_pin_resource:Resource   = save_system.open_file(map_name)
	var layers:Array                   = _temp_pin_resource.layers
	return layers

func get_first_layer(map_name:String)->Array:
	var layer = self.get_layers(map_name)[0]
	return layer

func get_last_layer(map_name:String)->Array:
	var layer = self.get_layers(map_name)[-1]
	return layer


func get_layer(map_name:String, layer_index:int)->Array:
	var layer = self.get_layers(map_name)[layer_index]
	return layer
