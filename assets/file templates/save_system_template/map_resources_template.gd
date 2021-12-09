class_name MapData
extends Resource

# === DATA OF THE MAP ====

export(String)                      var map_name:String  setget set_map_name, get_map_name  # name of the map
export(Array, Array, Resource)      var layers:Array     setget set_layers, get_layers   # layer used in the map

func set_map_name(name:String):
	map_name = name

func get_map_name() -> String:
	return map_name

func set_layers(new_layers:Array):
	layers = new_layers
	
func get_layers() -> Array:
	return layers
