class_name MapComment
extends Resource

enum {
	EXPAND,
	COLLAPSE
}

# === MAP PIN ===

@export var comment_name: String:String        = ""            # name of the comment
@export var comment_id: String:String                          # id of the comment
@export var comment_location: Vector2:Vector2   = Vector2(0, 0) # location of the pin in the map
@export var comment_text:String        = ""            # comment text # (String, MULTILINE)
@export var comment_state:int          = 0             # state of the comment window # (int, "expand", "collaspes")

# === methods ===

static func fetch_save_path()->String:
	var path:String = SystemDataManager.root_save_file_path + \
	"/pins/{uuid}_save_data.tres"

	return path
