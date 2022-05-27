class_name MapComment
extends Resource

# === MAP PIN ===

export(String)            var comment_name:String              = ""             # name of the comment
export(String)            var comment_id:String                                 # id of the comment
export(Vector2)           var comment_location:Vector2                          # location of the pin in the map
export(String, MULTILINE) var comment_text:String                               # comment text

# === methods ===

static func fetch_save_path()->String:
	var path:String = SystemDataManager.root_save_file_path + \
	"/pins/{uuid}_save_data.tres"

	return path
