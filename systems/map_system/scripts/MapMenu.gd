extends Control
# === Node ===

onready var menu:Control = $"../../../../.."
var map_creator:PackedScene = load("res://systems/map_system/ui_elements/map_creator/MapCreator.tscn")

func _on_Button_pressed():
	menu.add_child(map_creator.instance())
