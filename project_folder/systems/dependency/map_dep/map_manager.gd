# this handles the map properties
class_name MapPropertyManager
extends RefCounted

# fetches all the tags in a map resource
static func get_tags(map_name:String) -> Array:
	var _temp_pin_resource:Resource     = load(SystemDataManager.root_map_save_path.format({'uuid' : map_name}))
	var tags:Array                      = _temp_pin_resource.tags

	CommandSystem.API.echo("list of all tags: {0}".format([str(tags)]))

	return tags

# fetches all the pin from a map resource
static func get_all_pins(map_name:String)->Array:
	var chunk_data = load(SystemDataManager.root_map_save_path.format({'uuid' : map_name}))
	var pins       = chunk_data.map_pins

	CommandSystem.API.echo("list of all pin: {0}".format([str(pins)]))

	return pins

# fetches all the pin by name form a map resource
static func get_pins_by_name(map_name:String, pin_name:String) -> Array:
	var pins = get_all_pins(map_name)
	var temp_pins:Array = []
	for x in pins:
		if pin_name in x.pin_name:
			temp_pins.append(x)
		else:
			pass

	CommandSystem.API.echo("list of all pin with name {1}: {0}".format([str(temp_pins), pin_name]))

	return temp_pins

# fetches the last pin a map resource
static func get_last_pin(map_name:String)->MapPin:
	var pins = get_all_pins(map_name)

	CommandSystem.API.echo("last pin: {0}".format([str(pins[-1])]))
	return pins[-1]

# fetches all the last 
static func get_first_pin(map_name:String)->MapPin:
	var pins = get_all_pins(map_name)

	CommandSystem.API.echo("first pin: {0}".format([str(pins[0])]))
	return pins[0]

