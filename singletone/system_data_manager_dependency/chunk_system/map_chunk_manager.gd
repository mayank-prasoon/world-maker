extends Node
# === NODE ===

onready var root_node:Node   = self.get_parent().get_parent()
onready var save_system:Node = self.get_parent().get_node("SaveSystem")


func get_all_pins(chunk_name:String)->Array:
	var chunk_data = save_system.open_file(chunk_name)
	var pins       = chunk_data.chunk_pins
	return pins


func get_pins_by_name(chunk_name:String, pin_name:String) -> Array:
	var pins = self.get_all_pins(chunk_name)
	var temp_pins:Array = []
	for x in pins:
		if pin_name in x.pin_name:
			temp_pins.append(x)
		else:
			pass
			
	return temp_pins


func get_last_pin(chunk_name:String)->MapPin:
	var pins = self.get_all_pins(chunk_name)
	return pins[-1]


func get_first_pin(chunk_name:String)->MapPin:
	var pins = self.get_all_pins(chunk_name)
	return pins[0]

