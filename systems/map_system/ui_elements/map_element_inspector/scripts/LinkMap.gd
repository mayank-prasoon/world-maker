extends "res://systems/map_system/ui_elements/map_element_inspector/inspector_input.gd"

func _ready()->void:
	set_input_value(get_owner().resource_file.linked_map)

func _on_OptionButton_item_selected(index:int):
	var map_resource = load(get_owner().map_list.values()[index])
	set_input_value(map_resource)
