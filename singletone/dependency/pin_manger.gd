extends Node

# === NODES ===

onready var root_node:Node   = self.get_parent().get_parent()
onready var save_system:Node = self.get_parent().get_node("SaveSystem")

# === METHOD ===

# retruns the article associated with the pin
func get_article(pin_name:String) -> Resource:
	var _temp_pin_resource:Resource    = save_system.open_file(pin_name)
	var _raw_atricle_resource:Resource = _temp_pin_resource.pin_article
	return _raw_atricle_resource

func get_chunk(pin_name:String) -> MapChunkData:
	var _temp_pin_resource:Resource      = save_system.open_file(pin_name)
	var _raw_chunk_resource:MapChunkData = _temp_pin_resource.linked_chunk
	return _raw_chunk_resource

func get_template(pin_name:String) -> MapSymbolTemplate:
	var _temp_pin_resource:Resource              = save_system.open_file(pin_name)
	var _raw_template_resource:MapSymbolTemplate = _temp_pin_resource.pin_symbol_template
	return _raw_template_resource

func get_tags(pin_name:String) -> Array:
	var _temp_pin_resource:Resource     = save_system.open_file(pin_name)
	var tags:Array                      = _temp_pin_resource.tags
	return tags
