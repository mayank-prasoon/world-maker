extends Control

var threads:Array    = []
var map:MapData
var mutex            = Mutex.new()

func _ready():
	display_entire_map(load("res://save_files/maps/test_save_data.tres"))

func display_entire_map(map:MapData) -> void:
	var new_texture = TextureRect.new()
	$Map/TileMap.tile_set = map.image

	for y in 15:
		for x in 15:
			$Map/TileMap.set_cell(x, y, (y * 15 + x))
			
	
func _exit_tree():
	for x in threads:
		x.wait_to_finish()
