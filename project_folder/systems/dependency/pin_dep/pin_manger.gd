class_name PinManager
extends RefCounted

# retruns the article associated with the pin
static func get_article(pin_name:String) -> Resource:
	var _temp_pin_resource:Resource    = ResourceManager.open_file(pin_name, ResourceManager.PIN)
	var _raw_atricle_resource:Resource = _temp_pin_resource.pin_article

	CommandSystem.API.echo("article linked to pin: {0}".format([_raw_atricle_resource]))
	
	return _raw_atricle_resource


static func get_template(pin_name:String) -> MapSymbolTemplate:
	var _temp_pin_resource:Resource              = ResourceManager.open_file(pin_name, ResourceManager.PIN)
	var _raw_template_resource:MapSymbolTemplate = _temp_pin_resource.pin_symbol_template

	CommandSystem.API.echo("template linked to pin: {0}".format([_raw_template_resource]))

	return _raw_template_resource

static func get_tags(pin_name:String) -> Array:
	var _temp_pin_resource:Resource     = ResourceManager.open_file(pin_name, ResourceManager.PIN)
	var tags:Array                      = _temp_pin_resource.tags
	
	CommandSystem.API.echo("list of all the tags: {0}".format([str(tags)]))

	return tags
