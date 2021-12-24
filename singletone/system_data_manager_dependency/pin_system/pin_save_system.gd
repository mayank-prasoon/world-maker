extends SaveSystem

# === VARIABLES ===

func _ready():
	resource_type = root_node.MAP_RESOURCE_TYPE.PIN
	save_location = root_node.root_save_file_path + '/pins/{uuid}_save_data.tres' 

# save file
func save_file(
		pin_name:String,
		pin_id:String       = root_node.uuid_util.v4(),
		template:Resource   = MapSymbolTemplate.new(),
		location:Vector2    = Vector2(0,0),
		article:Resource    = Resource.new(),
		link_state:bool     = false,
		chunk_link:Resource = MapChunkData.new(),
		tags:Array          = []
	) -> void:
	
	LoggingSystem.log_new_event(name + " - " + "save_file({0},{1},{2},{3},{4},{5},{6},{7})".format([pin_name, pin_id, str(template), str(location), str(article), link_state, str(chunk_link), str(tags)]))
	
	var newSavePin                  = MapPin.new()
	newSavePin.pin_name             = pin_name
	newSavePin.pin_id               = pin_id
	newSavePin.pin_symbol_template  = template
	newSavePin.pin_location         = location
	newSavePin.pin_article          = article
	newSavePin.map_link_state       = link_state
	newSavePin.linked_chunk         = chunk_link
	newSavePin.tags                 = tags

	var _x = ResourceSaver.save(
		save_location.format({"uuid": pin_id}),
		newSavePin
	)
	
	CommandSystem.API.echo("pin saved:")
	CommandSystem.API.echo(save_location.format({"uuid": pin_id}))
	
