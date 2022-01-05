extends Node

onready var save_system    = get_node("SaveSystem")
onready var system_manager = get_node("MapManager")
onready var map_gen        = get_node("MapchunkGenerator")

func _ready()->void:
	Logger.info(name + " node loaded")
	generate_map("house", "/home/mayank/Downloads/pexels-james-wheeler-417074.jpg")

func generate_map(map_name:String, img_path:String, tags:Array = []):
	var map_chunks = map_gen.slice_texture(img_path)

	save_system.save_file(
		map_name,
		map_chunks,
		tags
	)
