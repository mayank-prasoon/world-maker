extends Control

var threads:Array    = []
var map:MapData
var mutex            = Mutex.new()

func display_entire_map(map:MapData) -> void:
	self.get_child(0).tile_set = map.image

	for y in 15:
		for x in 15:
			self.get_child(0).set_cell(x, y, (y * 15 + x))
			

func _exit_tree():
	for x in threads:
		x.wait_to_finish()
