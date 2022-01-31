extends Control

# === Nodes ===
var canvas_layer = get_parent().get_node("Camera2D/CanvasLayer")

# thread and thread related vars
var threads:Array    = []
var mutex:Mutex      = Mutex.new()

# map manager laod map method
func _on_MapManager_load_map(map_path:String) -> void:
	display_entire_map(load(map_path))

# NOTE: depricated
func _exit_tree()->void:
	for x in threads:
		x.wait_to_finish()


#                 === DANGER ZONE ===                   #
# ----------------------------------------------------- #
#    following code are depricated or need a overhall   #
#                or a work in progress                  #
#                                                       #
#              !!PROCEED WITH CAUTION!!                 #
#                                                       #


# display entire map
# NOTE: this only for testing purposes
func display_entire_map(map:MapData) -> void:
	self.get_child(0).tile_set = map.image
	
	# instance and add the loading scene to the scene	
	var temp_packed_scene:PackedScene = load("res://systems/dependency/ui_elements/loading_screen/LoadingScene.tscn")
	var loading_screen:Control        = temp_packed_scene.instance()

	# add min and max value
	loading_screen.min_value = 0
	loading_screen.max_value = map.chunk_number
	
	# initialize the node
	canvas_layer.add_child(loading_screen)
	canvas_layer.get_node("LoadingScene").set_min_max(0, map.chunk_number)

	# display the tile set
	# Note:x is the x-axis and y is the y-axis
	for y in sqrt(map.chunk_number):
		for x in sqrt(map.chunk_number):
			# position of the tile in the tilset
			var tile_index:int = (y * 15 + x)
			
			self.get_child(0).set_cell(x, y, tile_index)
			# increase the new_value based on the index of the tile in the tilset
			canvas_layer.get_node("LoadingScene").emit_signal("set_new_value", tile_index)
