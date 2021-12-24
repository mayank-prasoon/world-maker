extends Node

onready var root_node:Node   = self.get_parent().get_parent()
onready var save_system:Node = self.get_parent().get_node("SaveSystem")

func _ready():
	LoggingSystem.log_new_event(name + " node loaded")

func get_tags(map_name:String) -> Array:
	LoggingSystem.log_new_event(name + " - " + "get_tags({0})".format([map_name]))
	
	var _temp_pin_resource:Resource     = save_system.open_file(map_name)
	var tags:Array                      = _temp_pin_resource.tags

	CommandSystem.API.echo("list of all tags: {0}".format([str(tags)]))

	return tags
	
	
func get_layers(map_name:String) -> Array:
	LoggingSystem.log_new_event(name + " - " + "get_layers({0})".format([map_name]))
	var _temp_pin_resource:Resource   = save_system.open_file(map_name)
	var layers:Array                   = _temp_pin_resource.layers

	CommandSystem.API.echo("list of all layers: {0}".format([str(layers)]))

	return layers

func get_first_layer(map_name:String)->Array:
	LoggingSystem.log_new_event(name + " - " + "get_first_layer({0})".format([map_name]))
	var layer = self.get_layers(map_name)[0]

	CommandSystem.API.echo("first layer: {0}".format([str(layer)]))

	return layer

func get_last_layer(map_name:String)->Array:
	LoggingSystem.log_new_event(name + " - " + "get_last_layer({0})".format([map_name]))

	var layer = self.get_layers(map_name)[-1]
	
	CommandSystem.API.echo("last layer: {0}".format([str(layer)]))
	
	return layer



func get_layer(map_name:String, layer_index:int)->Array:
	LoggingSystem.log_new_event(name + " - " + "get_layer({0})".format([map_name]))

	var layer = self.get_layers(map_name)[layer_index]

	CommandSystem.API.echo("layer: {0}".format([str(layer)]))

	return layer
