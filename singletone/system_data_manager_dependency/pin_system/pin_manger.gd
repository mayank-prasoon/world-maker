extends Node

# === NODES ===

onready var root_node:Node   = self.get_parent().get_parent()
onready var save_system:Node = self.get_parent().get_node("SaveSystem")

# === METHOD ===

# retruns the article associated with the pin
func get_article(pin_name:String) -> Resource:
	Logger.info(name + " - " + "get_article({0})".format([pin_name]))
	
	var _temp_pin_resource:Resource    = save_system.open_file(pin_name)
	var _raw_atricle_resource:Resource = _temp_pin_resource.pin_article

	CommandSystem.API.echo("article linked to pin: {0}".format([_raw_atricle_resource]))
	
	return _raw_atricle_resource
#
#func get_chunk(pin_name:String) -> MapChunkData:
#	Logger.info(name + " - " + "get_chunk({0})".format([pin_name]))
#
#	var _temp_pin_resource:Resource      = save_system.open_file(pin_name)
#	var _raw_chunk_resource:MapChunkData = _temp_pin_resource.linked_chunk
#
#	CommandSystem.API.echo("chunk linked to pin: {0}".format([_raw_chunk_resource]))
#
#	return _raw_chunk_resource

func get_template(pin_name:String) -> MapSymbolTemplate:
	Logger.info(name + " - " + "get_template({0})".format([pin_name]))

	var _temp_pin_resource:Resource              = save_system.open_file(pin_name)
	var _raw_template_resource:MapSymbolTemplate = _temp_pin_resource.pin_symbol_template

	CommandSystem.API.echo("template linked to pin: {0}".format([_raw_template_resource]))

	return _raw_template_resource

func get_tags(pin_name:String) -> Array:
	Logger.info(name + " - " + "get_tags({0})".format([pin_name]))

	var _temp_pin_resource:Resource     = save_system.open_file(pin_name)
	var tags:Array                      = _temp_pin_resource.tags
	
	CommandSystem.API.echo("list of all the tags: {0}".format([str(tags)]))

	return tags
