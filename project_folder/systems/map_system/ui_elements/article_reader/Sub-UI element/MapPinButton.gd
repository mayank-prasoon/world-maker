extends Control

var map_pin_node:Node2D     = null
var map_pin_resource:MapPin = null

func _ready():
	if map_pin_resource.pin_name == "":
		$HBoxContainer/Label.text = 'id : ' + map_pin_resource.pin_id
	else:
		$HBoxContainer/Label.text = map_pin_resource.pin_name

	if map_pin_resource.pin_symbol_template.template_texture != "":
		$HBoxContainer/TextureRect.texture = ImageHandler.load_image_texture(map_pin_resource.pin_symbol_template.template_texture, Texture.FLAG_ANISOTROPIC_FILTER)


func _on_MapPin_gui_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == BUTTON_LEFT:
			EventBus.emit_signal("move_camera_to", map_pin_resource.pin_location)
