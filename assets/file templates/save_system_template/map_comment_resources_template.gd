class_name MapComment
extends Resource

enum {
	EXPAND,
	COLLAPSE
}

# === MAP PIN ===

export(String)                     var comment_name:String        = ""            # name of the comment
export(String)                     var comment_id:String                          # id of the comment
export(Vector2)                    var comment_location:Vector2   = Vector2(0, 0) # location of the pin in the map
export(String, MULTILINE)          var comment_text:String        = ""            # comment text
export(int, "expand", "collaspes") var comment_state:int          = 0             # state of the comment window

# === methods ===

static func fetch_save_path()->String:
	var path:String = SystemDataManager.root_save_file_path + \
	"/pins/{uuid}_save_data.tres"

	return path
