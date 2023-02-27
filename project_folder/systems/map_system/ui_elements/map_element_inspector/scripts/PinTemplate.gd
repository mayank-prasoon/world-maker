extends "res://systems/map_system/ui_elements/map_element_inspector/inspector_input.gd"

# ------------------------------------------------------------------------------

# === SIGNALS ===

func _on_OptionButton_item_selected(index:int)->void:
	set_input_value(index)
	assign_texture(index)


func assign_texture(index)->void:
	var texture = ImageHandler.load_image_texture(get_owner().pin_templates[index].template_texture)
	$"../PinTexture/VBoxContainer/Panel/TextureRect".texture = texture


func _on_Button_pressed():
	var symbol_template_scene:PackedScene = load("res://systems/map_system/ui_elements/map_pin_symbol_creator/MapPinTemplateCreator.tscn")
	var symbol_template_node = symbol_template_scene.instance()
	get_owner().get_parent().get_owner().get_node("Camera2D/CanvasLayer/Menu").add_child(symbol_template_node)
	EventBus.emit_signal("change_inspector_state", false)
