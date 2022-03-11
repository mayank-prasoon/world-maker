class_name MapSymbolTemplate
extends Resource

# === MAP SYMBOLTEMPLATE ===

export(String)          var template_name:String                                         # name of the symbol template     
export(String, FILE)    var template_texture:String                                      # texture path of the template
export(Vector2)         var template_offset:Vector2                                      # offset of the template
export(Color)           var template_color:Color                                         # color of the symbol

# === methods ===

static func fetch_save_path()->String:
	var path:String = SystemDataManager.root_save_file_path + \
	"/map_symbol_templates/{uuid}_save_data.tres"

	return path
