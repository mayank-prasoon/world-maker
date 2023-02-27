class_name Article
extends Resource

@export var article_name: String:String
@export var article_id: String:String
@export var article_profile:String # (String, FILE)
@export var article_banner:String # (String, FILE)
@export var article_type: int:int
@export var article_template: Resource:Resource
@export var article_notes: String:String
@export var article_raw:String # (String, MULTILINE)
@export var article_description: String:String
@export var tags:Array # (Array, String)
@export var article_resources: String:String

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
