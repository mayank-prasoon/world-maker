extends SaveSystem

func _ready():
	save_location = self.root_node.root_save_file_path + '/maps/{uuid}_save_data.tres'
	resource_type = self.root_node.MAP_RESOURCE_TYPE.MAP

func save_file(
		map_name:String,
		layers:String       = "",
		chunk_size:Vector2  = Vector2(0,0),
		chunk_number:int    = 0,
		map_pins:Array      = [],
		tags:Array          = []
	) -> void:

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
