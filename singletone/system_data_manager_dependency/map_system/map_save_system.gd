extends SaveSystem

func _ready():
	Logger.info(name + " node loaded")
	save_location = self.root_node.root_save_file_path + '/maps/{uuid}_save_data.tres'
	resource_type = self.root_node.MAP_RESOURCE_TYPE.MAP

func save_file(
		map_name:String,
		layers:TileSet      = TileSet.new(),
		chunk_size:Vector2  = Vector2(),
		chunk_number:int    = 0,
		map_pins:Array      = [],
		tags:Array          = []
	) -> void:

	Logger.info(name + " - " + "save_file({0},{1},{2})".format([map_name, str(layers), str(tags)]))

	var newMapData          = MapData.new()
	newMapData.map_name     = map_name
	newMapData.image        = layers
	newMapData.chunk_size   = chunk_size
	newMapData.chunk_number = chunk_number
	newMapData.map_pins     = map_pins
	newMapData.tags         = tags
	
	var t = Thread.new()
	threads.append(t)

	# save data using thread
	t.start(
		self,
		"save_data",
		[
			save_location.format({"uuid": map_name}),
			newMapData
		]
	)

	CommandSystem.API.echo("map saved:")
	CommandSystem.API.echo(save_location.format({"uuid": map_name}))

func _exit_tree():
	for x in threads:
		x.wait_to_finish()
