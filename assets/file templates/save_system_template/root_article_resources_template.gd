class_name Article
extends Resource

export(String)            var article_name:String
export(String)            var article_id:String
export(String, FILE)      var article_profile:String
export(String, FILE)      var article_banner:String
export(int)               var article_type:int
export(Resource)          var article_template:Resource
export(String)            var article_notes:String
export(String, MULTILINE) var article_raw:String
export(String)            var article_description:String
export(Array, String)     var tags:Array
export(String)            var article_resources:String

const BASIC = 0
const MAP   = 1
const PIN   = 2

# === methods ===

# get name
static func get_type_name(type:int)->String:
	match type:
		BASIC:
			return "basic"
		MAP:
			return "map"
		PIN:
			return "pin"
		_:
			return ""


static func fetch_save_path()->String:
	var path:String = SystemDataManager.root_save_file_path + \
	"/articles/{uuid}_save_data.tres"

	return path
