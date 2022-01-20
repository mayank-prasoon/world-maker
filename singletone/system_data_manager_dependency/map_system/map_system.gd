extends Node

onready var save_system    = get_node("SaveSystem")
onready var system_manager = get_node("MapManager")
onready var map_gen        = get_node("MapchunkGenerator")


func _ready()->void:
	Logger.info(name + " node loaded")


func generate_map(map_name:String, img_path:String, tags:Array = [], pins:Array = [], chunk_size:Vector2 = Vector2(512, 288)):
	var map_tile:TileSet   = map_gen.slice_texture(img_path)
	var image_size:Vector2 = map_gen.load_image(img_path).get_size()
	var chunk_counter:int  = map_gen.get_chunk_count(image_size, chunk_size)

	save_system.save_file(
		map_name,
		map_tile,
		Vector2(sqrt(chunk_counter), sqrt(chunk_counter)),
		chunk_counter,
		pins,
		tags
	)

func _on_SaveSystem_data_saved():
	print("saved")
