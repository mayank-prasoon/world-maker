class_name MapSystem
extends RefCounted

# return the array of map resources paths
static func get_maps()->Array:
	var path:String = SystemDataManager.root_map_save_path
	var maps:Array  = FolderManager.fetch_files_from(path.get_base_dir(), true)

	CommandSystem.API.echo("list of article : {0}".format([str(maps)]))

	return maps

# genrate map
static func generate_map(
	map_name:String,
	img_path:String,
	chunk_size:Vector2 = Vector2(512, 288)
	)->void:

	MapGen.generate_map(
		map_name,
		img_path,
		chunk_size
	)
