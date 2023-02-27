class_name MapData
extends Resource

# === DATA OF THE MAP ====

@export var map_name: String:String               # name of the map
@export var image_path:String             # path to the image  # (String, FILE)
@export var image_size: Vector2:Vector2            # size of the image
@export var layers:Array                  # layer used in the map # (Array, Resource)
@export var map_pins:Array                # map pins # (Array, Resource)
@export var tags:Array                    # tags # (Array, String)

# === methods ===

static func fetch_save_path()->String:
	var path:String = SystemDataManager.root_save_file_path + \
	"/maps/{uuid}_save_data.tres"
	
	return path



# default template prompts
# export var template_prompts:Array = [ # (Array, Dictionary)
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
