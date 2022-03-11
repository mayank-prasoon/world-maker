extends Control
# === Node ===

onready var menu:Control = $"../../../../.."
var map_creator:PackedScene = load("res://systems/map_system/ui_elements/map_creator/MapCreator.tscn")

# map creator as child
func _on_Button_pressed():
	get_tree().get_nodes_in_group('camera_movement')[0].disableMouse = true
	menu.add_child(map_creator.instance())
