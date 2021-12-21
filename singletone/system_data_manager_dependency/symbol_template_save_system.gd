extends SaveSystem

func _ready():
	save_location = self.root_node.root_save_file_path + '/map_symbol_templates/{uuid}_save_data.tres'
	resource_type = self.root_node.MAP_RESOURCE_TYPE.PIN_TEMPLATE
	
func save_file(
		template_name:String,
		texture:String  = "xyz",
		offset:Vector2  = Vector2(0,0),
		color:Color     = Color.white 
	) -> void:

	var newMapSymbolTemplateData               = root_node.mapSymbolTemplate.new()
	newMapSymbolTemplateData.template_name     = template_name
	newMapSymbolTemplateData.template_offset   = offset
	newMapSymbolTemplateData.template_texture  = texture
	newMapSymbolTemplateData.template_color    = color

	var _x = ResourceSaver.save(
		save_location.format({"uuid": template_name}),
		newMapSymbolTemplateData
	)
