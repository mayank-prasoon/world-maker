class_name MapSymbolTemplate
extends Resource

# === MAP SYMBOLTEMPLATE ===

@export var template_name: String:String                                         # name of the symbol template     
@export var template_texture:String                                      # texture path of the template # (String, FILE)
@export var template_hover_animation:Array                               # animtion which is played checked hover # (Array, String, FILE)
@export var template_offset: Vector2:Vector2                                      # offset of the template
@export var template_color: Color:Color                                         # color of the symbol
@export var template_area2D_radius: float:int = 48
@export var template_default_tag:Array # (Array, String)
@export var template_default_article_template:String # (String, FILE)

# === methods ===

static func fetch_save_path()->String:
	var path:String = SystemDataManager.root_save_file_path + \
	"/map_symbol_templates/{uuid}_save_data.tres"

	return path
