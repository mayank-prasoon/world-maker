extends Node

# === EXPORTS ===

onready var root_node:Node = self.get_parent().get_parent()

# === VARIABLES ===

onready var save_location = self.root_node.root_save_file_path + '/map_chunks/{uuid}_save_data.tres' 


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

# open file
func open_file(chunk_id:String)->Resource:
	root_node.verify(
		save_location.format({"uuid": chunk_id}),
		root_node.MAP_RESOURCE_TYPE.MAP_CHUNK,
		chunk_id
	)
	
	var newMapChunkData = ResourceLoader.load(save_location.format({"uuid": chunk_id}))
	return newMapChunkData

# remove all file
func remove_all_files() -> void:
	var folder = Directory.new()
	var base_folder = save_location.get_base_dir()

	if folder.dir_exists(base_folder):
		folder.open(base_folder)
		folder.list_dir_begin()
		while true:
			var file = folder.get_next()
			if file == "":
				break
			elif not file.begins_with("."):
				folder.remove(base_folder + '/' + file)
		folder.list_dir_end()

# removes file
func remove_file(chunk_id:String) -> void:
	var file = Directory.new()
	file.remove(save_location.format({"uuid": chunk_id}))
