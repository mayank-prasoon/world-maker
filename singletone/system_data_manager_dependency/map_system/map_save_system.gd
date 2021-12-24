extends SaveSystem

func _ready():
	LoggingSystem.log_new_event(name + " node loaded")
	save_location = self.root_node.root_save_file_path + '/maps/{uuid}_save_data.tres'
	resource_type = self.root_node.MAP_RESOURCE_TYPE.MAP
	
func save_file(
		map_name:String,
		layers:Array      = [],
		tags:Array        = []
	) -> void:

	LoggingSystem.log_new_event(name + " - " + "save_file({0},{1},{2})".format([map_name, str(layers), str(tags)]))

	var newMapChunkData        = root_node.map.new()
	newMapChunkData.map_name   = map_name
	newMapChunkData.layers     = layers
	newMapChunkData.tags       = tags

	var _x = ResourceSaver.save(
		save_location.format({"uuid": map_name}),
		newMapChunkData
	)


	CommandSystem.API.echo("map saved:")
	CommandSystem.API.echo(save_location.format({"uuid": map_name}))
