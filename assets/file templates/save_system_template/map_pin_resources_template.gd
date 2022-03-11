class_name MapPin
extends Resource

# === MAP PIN ===

export(String)        var pin_name:String                                    # name of the pin
export(String)        var pin_id:String                                            # id of the pin
export(Resource)      var pin_symbol_template:Resource                             # symbol template used for the pin
export(Vector2)       var pin_location:Vector2                                     # location of the pin in the map
export(Resource)      var pin_article:Resource                                     # article attached to the pin
export(bool)          var map_link_state:bool                                      # state of the link
export(Vector2)       var linked_chunk:Vector2                                     # chunk which is linked to the pin
export(Array, String) var tags:Array

# === methods ===

static func fetch_save_path()->String:
	var path:String = SystemDataManager.root_save_file_path + \
	"/pins/{uuid}_save_data.tres"

	return path
