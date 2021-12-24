extends Node
# === NODE ===

onready var root_node:Node   = self.get_parent().get_parent()
onready var save_system:Node = self.get_parent().get_node("SaveSystem")

func _ready() -> void:
	LoggingSystem.log_new_event(name + " - node loaded")

func get_all_pins(chunk_name:String)->Array:
	LoggingSystem.log_new_event(name + " - " + "chunk_name({0})".format([chunk_name]))
	
	var chunk_data = save_system.open_file(chunk_name)
	var pins       = chunk_data.chunk_pins

	CommandSystem.API.echo("list of all pin: {0}".format([str(pins)]))
	return pins


func get_pins_by_name(chunk_name:String, pin_name:String) -> Array:
	LoggingSystem.log_new_event(name + " - " + "get_pins_by_name({0}, {1})".format([chunk_name, pin_name]))

	var pins = self.get_all_pins(chunk_name)
	var temp_pins:Array = []
	for x in pins:
		if pin_name in x.pin_name:
			temp_pins.append(x)
		else:
			pass
	
	CommandSystem.API.echo("list of all pin with name {1}: {0}".format([str(temp_pins), pin_name]))

	return temp_pins


func get_last_pin(chunk_name:String)->MapPin:
	LoggingSystem.log_new_event(name + " - " + "get_last_pin({0})".format([chunk_name]))

	var pins = self.get_all_pins(chunk_name)

	CommandSystem.API.echo("last pin: {0}".format([str(pins[-1])]))
	return pins[-1]


func get_first_pin(chunk_name:String)->MapPin:
	LoggingSystem.log_new_event(name + " - " + "get_first_pin({0})".format([chunk_name]))

	var pins = self.get_all_pins(chunk_name)

	CommandSystem.API.echo("first pin: {0}".format([str(pins[0])]))
	return pins[0]

