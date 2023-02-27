class_name MapPin
extends Resource

# === MAP PIN ===

@export var pin_name: String:String              = ""                        # name of the pin
@export var pin_id: String:String                                            # id of the pin
@export var pin_symbol_template: Resource:Resource = MapSymbolTemplate.new()   # symbol template used for the pin
@export var pin_location: Vector2:Vector2                                     # location of the pin in the map
@export var pin_article: Resource:Resource         = Article.new()             # article attached to the pin
@export var linked_map: Resource:Resource          = MapData.new()             # state of the link
@export var tags:Array                   = [] # (Array, String)

# === methods ===

static func fetch_save_path()->String:
	var path:String = SystemDataManager.root_save_file_path + \
	"/pins/{uuid}_save_data.tres"

	return path
