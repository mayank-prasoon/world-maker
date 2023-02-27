class_name MapData
extends Resource

# === DATA OF THE MAP ====

export(String)                      var map_name:String               # name of the map
export(String, FILE)                var image_path:String             # path to the image 
export(Vector2)                     var image_size:Vector2            # size of the image
export(Array, Resource)             var layers:Array                  # layer used in the map
export(Array, Resource)             var map_pins:Array                # map pins
export(Array, String)               var tags:Array                    # tags

# === methods ===

static func fetch_save_path()->String:
	var path:String = SystemDataManager.root_save_file_path + \
	"/maps/{uuid}_save_data.tres"
	
	return path



# default template prompts
# export(Array, Dictionary)           var template_prompts:Array = [
# 	{
# 		'name'        : 'Pins',
# 		'description' : 'pins in the the map',
# 		'type'        :  PresetInputManager.DATABASE,
# 		'value'       : 'fetch_pins',
# 		'display'     : 'the name of the land is {value}',
# 		'null_value'  : 'unknown',
# 		'script'      : "res://assets/file templates/save_system_template/fetchy_pins.gd"
# 	}
# ]
