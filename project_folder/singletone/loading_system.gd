extends CanvasLayer

var object:Object

func start_loading(new_object, max_chunk)->void:
	var temp_packed_scene:PackedScene = load("res://systems/dependency/ui_elements/loading_screen/LoadingScene.tscn")
	var loading_screen:Control        = temp_packed_scene.instantiate()

	# add min and max value
	loading_screen.min_value = 0
	loading_screen.max_value = max_chunk

	# initialize the node
	object = new_object
	object.add_child(loading_screen)


func add_value(new_value)->void:
	var node = object.get_node("LoadingScene")
	node.add_new_value(new_value)
