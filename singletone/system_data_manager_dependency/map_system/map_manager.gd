extends Node

onready var save_system:Node = self.get_parent().get_node("SaveSystem")

func _ready():
	Logger.info(name + " node loaded")


func get_tags(map_name:String) -> Array:
	Logger.info(name + " - " + "get_tags({0})".format([map_name]))
	
	var _temp_pin_resource:Resource     = save_system.open_file(map_name)
	var tags:Array                      = _temp_pin_resource.tags

	CommandSystem.API.echo("list of all tags: {0}".format([str(tags)]))

	return tags


func get_all_pins(map_name:String)->Array:
	Logger.info(name + " - " + "map_name({0})".format([map_name]))
	
	var chunk_data = save_system.open_file(map_name)
	var pins       = chunk_data.map_pins

	CommandSystem.API.echo("list of all pin: {0}".format([str(pins)]))

	return pins


func get_pins_by_name(map_name:String, pin_name:String) -> Array:
	Logger.info(name + " - " + "get_pins_by_name({0}, {1})".format([map_name, pin_name]))

	var pins = self.get_all_pins(map_name)
	var temp_pins:Array = []
	for x in pins:
		if pin_name in x.pin_name:
			temp_pins.append(x)
		else:
			pass

	CommandSystem.API.echo("list of all pin with name {1}: {0}".format([str(temp_pins), pin_name]))

	return temp_pins


func get_last_pin(map_name:String)->MapPin:
	Logger.info(name + " - " + "get_last_pin({0})".format([map_name]))
	var pins = self.get_all_pins(map_name)

	CommandSystem.API.echo("last pin: {0}".format([str(pins[-1])]))
	return pins[-1]


func get_first_pin(map_name:String)->MapPin:
	Logger.info(name + " - " + "get_first_pin({0})".format([map_name]))

	var pins = self.get_all_pins(map_name)

	CommandSystem.API.echo("first pin: {0}".format([str(pins[0])]))
	return pins[0]
