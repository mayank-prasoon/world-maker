extends RefCounted

var pins
var node

func _init(node):
	self.node = node
	self.node.connect('add_item',Callable(self,'create_pin'))
	
func create_pins(pin_name):
	print(pin_name)


func remove_pins():
	print("pin deleted")
	

func fetch_value(save_file:MapData)->Array:
	var pin_names:Array = []

	for x in save_file.map_pins:
		pin_names.append(x.pin_name)
		pins[x.pin_name] = x.pin_id 

	return pin_names
