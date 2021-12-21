extends SaveSystem

func _ready():
	save_location = self.root_node.root_save_file_path + '/map_chunks/{uuid}_save_data.tres'
	resource_type = self.root_node.MAP_RESOURCE_TYPE.MAP_CHUNK
	
func save_file(
		chunk_name:String,
		chunk_id:String = root_node.uuid_util.v4(),
		texture:String  = "xyz",
		offset:Vector2  = Vector2(0,0),
		pins:Array      = []
	) -> void:

	var newMapChunkData               = root_node.mapChunk.new()
	newMapChunkData.chunk_name        = chunk_name
	newMapChunkData.chunk_id          = chunk_id
	newMapChunkData.chunk_offset      = offset
	newMapChunkData.chunk_texture     = texture
	newMapChunkData.chunk_pins        = pins

	var _x = ResourceSaver.save(
		save_location.format({"uuid": chunk_id}),
		newMapChunkData
	)
