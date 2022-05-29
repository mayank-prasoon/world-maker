class_name MapPinNode
extends Node2D

# === VARIABLES ===

var animation_resource:SpriteFrames = SpriteFrames.new()
var pin_resource:MapPin             = MapPin.new()

var selected:bool                   = false
var disabled:bool                   = false
var desired_scale:Vector2           = self.scale

func _ready()->void:
	self.scale = Vector2(0, 0) # to add a pop out animation
	self.desired_scale = Vector2(0.6, 0.6) # to add a pop out animation
	
	add_to_group("map_element") # part of map element 
	add_to_group("map_pin")     # part of the map pin groups

	load_resource()
	add_animation_and_texture()

# ------------------------------------------------------------------------------

# load the resouces
func load_resource()->void:
	
	$Sprite.frames = animation_resource
	self.position  = pin_resource.pin_location

	$Area2D/CollisionShape2D.shape.radius = pin_resource.pin_symbol_template.template_area2D_radius

	$Control/ColorRect/Label.text  = pin_resource.pin_name

	$Control.rect_position = Vector2(0, pin_resource.pin_symbol_template.template_area2D_radius - 5)

	$Sprite.offset         = pin_resource.pin_symbol_template.template_offset

# ------------------------------------------------------------------------------

# add animation and texture to the map pin
func add_animation_and_texture()->void:
	animation_resource.add_animation("hover")
	
	if pin_resource.pin_symbol_template == null:
		pin_resource.pin_symbol_template = MapSymbolTemplate.new()
	
	var animation_frame_added:bool = false
	for x in pin_resource.pin_symbol_template.template_hover_animation:
		if x != "":
			animation_resource.add_frame("hover", ImageHandler.load_map_pin_texture(x))
			animation_frame_added  = true

	if !animation_frame_added and pin_resource.pin_symbol_template.template_texture == "":
		animation_resource.add_frame("hover", load("res://assets/graphics/map_pin.svg"))
	elif !animation_frame_added and pin_resource.pin_symbol_template.template_texture != "":
		animation_resource.add_frame("hover", ImageHandler.load_map_pin_texture(pin_resource.pin_symbol_template.template_texture))

	if pin_resource.pin_symbol_template.template_texture != "":
		animation_resource.add_frame("default", ImageHandler.load_map_pin_texture(pin_resource.pin_symbol_template.template_texture))
	else:
		animation_resource.add_frame("default", load("res://assets/graphics/map_pin.svg"))

# ------------------------------------------------------------------------------

func save_pin()->void:
	ResourceManager.save_file(
		{
			"pin_name"            : pin_resource.pin_name,
			"pin_id"              : pin_resource.pin_id,
			"pin_location"        : pin_resource.pin_location,
			"pin_symbol_template" : pin_resource.pin_symbol_template,
			"pin_article"         : pin_resource.pin_article,
			"linked_map"          : pin_resource.linked_map,
			"tags"                : pin_resource.tags
		},
		ResourceManager.PIN
	)


func _process(delta):
	self.scale = lerp(self.scale, self.desired_scale, 0.5)
	
	var camera_array = get_tree().get_nodes_in_group('camera_movement')

	if camera_array.size() != 0:
		desired_scale = camera_array[0].desiredZooom


func _on_Area2D_mouse_entered()->void:
	EventBus.emit_signal("mouse_inside_map_element", self)


func _on_Area2D_mouse_exited()->void:
	EventBus.emit_signal("mouse_outside_map_element")


func _on_Area2D_area_entered(area:Area2D)->void:
	if area.get_parent().get_position_in_parent() > self.get_position_in_parent():
		disabled = true


func _on_Area2D_area_exited(area:Area2D)->void:
	if area.get_parent().get_position_in_parent() > self.get_position_in_parent():
		disabled = false
