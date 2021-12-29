extends SaveSystem

func _ready():
	Logger.info(name + " - node loaded")

	save_location = self.root_node.root_save_file_path + '/map_chunks/{uuid}_save_data.tres'
	resource_type = self.root_node.MAP_RESOURCE_TYPE.MAP_CHUNK
	
func save_file(
		chunk_name:String,
		chunk_id:String = root_node.uuid_util.v4(),
		chunk_texture:String  = "xyz",
		chunk_offset:Vector2  = Vector2(0,0),
		pins:Array      = []
	) -> void:

	Logger.info(name + " - " + "save_file({0},{1},{2},{3},{5})".format([chunk_name, chunk_id, chunk_texture, chunk_offset, str(pins)]))

	var newMapChunkData               = MapChunkData.new()
	newMapChunkData.chunk_name        = chunk_name
	newMapChunkData.chunk_id          = chunk_id
	newMapChunkData.chunk_offset      = chunk_offset
	newMapChunkData.chunk_texture     = chunk_texture
	newMapChunkData.chunk_pins        = pins

	var _x = ResourceSaver.save(
		save_location.format({"uuid": chunk_id}),
		newMapChunkData
	)

	CommandSystem.API.echo("chunk saved:")
	CommandSystem.API.echo(save_location.format({"uuid": chunk_id}))
