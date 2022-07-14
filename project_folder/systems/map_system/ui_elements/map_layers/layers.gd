extends Control

signal mouse_pointer_entered
signal mouse_pointer_exited

# === VARIABLE === 

var texture_node:TextureRect   = TextureRect.new()

var map_layer_resources:MapLayer = MapLayer.new()

var move:bool        = false

var mouse_enter:bool = false
var hover:bool       = false

var default_style_box  = preload("res://systems/map_system/ui_elements/map_layers/theme/default_layer_style_box.tres")
var selected_style_box = preload("res://systems/map_system/ui_elements/map_layers/theme/selected_layer_style.tres")

var selected:bool      = false       # true when the node is selected
# variable realated to animation

var default_rect_size
var default_rect_pos

var rect_size_value:Vector2 = Vector2(272, 30)
var rect_pos_value:Vector2  = Vector2(0, 0)

# === INNER CLASS(s) ===

# ------------------------------------------------------------------------------

func _ready()->void:
	# assign default value
	$Panel.rect_size  = Vector2(272, 30)
	$Panel.rect_position = Vector2(0, 0)
	
	default_rect_size = Vector2(272, 30)
	default_rect_pos  = Vector2(0, 0)
	
	# add to group
	add_to_group('map_layers')
	
	# assign layer 
	setup_layer()
	layer_selected()

func setup_layer()->void:
	# assign name
	self.name = map_layer_resources.layer_name
	$Panel/HBoxContainer/Label.text = self.name
	
	# assign texture
	texture_node.modulate = Color(1, 1, 1, float(map_layer_resources.layer_opacity)/100)
	texture_node.material = MapLayer.fetch_shader_material(
		map_layer_resources.layer_shader,
		map_layer_resources.layer_custom_shader
	)

	# assign visibility
	$Panel/HBoxContainer/Visible.pressed = !map_layer_resources.layer_visibility
	texture_node.visible = map_layer_resources.layer_visibility


# ------------------------------------------------------------------------------

# system loop
func _physics_process(_delta:float)->void:
	lerp_animation()
	check_mouse_enter()


# system input loop
func _input(event):
	if move == true:
		if event is InputEventMouseButton:
			if !event.is_pressed() and event.button_index == BUTTON_LEFT:
				get_tree().call_group('map_layers', '_on_being_dragged', false)

# ------------------------------------------------------------------------------

func layer_selected()->void:
	for node in get_tree().get_nodes_in_group('map_layers'):
		node.get_node("Panel").set("custom_styles/panel", default_style_box)
		node.get_node("Panel/HBoxContainer/Label").set('modulate', Color('e0e0e0'))
		node.get_node("Panel/HBoxContainer/Visible").set('modulate', Color('e0e0e0'))
		node.selected = false

	selected = true
	get_tree().call_group('layer_option', 'set_map_layer', self)
	$Panel.set("custom_styles/panel", selected_style_box)
	$Panel/HBoxContainer/Visible.modulate = Color('252525')
	$Panel/HBoxContainer/Label.modulate   = Color('252525')

# gui input loop
func _on_Layers_gui_input(event)->void:
	if if_inside_rect():
		if event is InputEventMouse:
			if event.is_pressed() and event.button_index == BUTTON_LEFT:
				layer_selected()
				get_tree().call_group('map_layers', '_on_being_dragged', true)
				reset_to_default()

# ------------------------------------------------------------------------------

# === UI ANIMATIONS ===

func lerp_animation()->void:
	$Panel.rect_position = Vector2(
		lerp($Panel.rect_position.x, rect_pos_value.x, 0.35),
		lerp($Panel.rect_position.y, rect_pos_value.y, 0.35)
	)

	$Panel.rect_size     = Vector2(
		lerp($Panel.rect_size.x, rect_size_value.x, 0.35),
		lerp($Panel.rect_size.y, rect_size_value.y, 0.35)
	)


func set_position_size_value(pos:Vector2, size:Vector2):
	rect_pos_value  = pos
	rect_size_value = size


func reset_to_default()->void:
	set_position_size_value(default_rect_pos, default_rect_size)


# ------------------------------------------------------------------------------


# === DARG AND DROP SYSTEM ===

# exicutes when the control node is being dragged
func get_drag_data(_position)->Dictionary:
	
	# assign data
	var data = {}
	
	data["node_position"] = self.get_position_in_parent()
	data["layer"]         = self
	data["layer_node"]    = self.texture_node
	
	# create preview texture
	var texture              = ColorRect.new()
	texture.color            = Color('25252a')
	texture.rect_min_size    = Vector2(100,50)

	var label                = Label.new()
	label.text               = name
	label.align              = Label.ALIGN_CENTER
	label.valign             = Label.VALIGN_CENTER
	label.rect_min_size      = texture.rect_min_size
	
	texture.add_child(label)
	
	var control:Control      = Control.new()
	control.add_child(texture)
	texture.rect_position = texture.rect_min_size * - 0.5

	set_drag_preview(control)

#	hover = false # prevent animation form firing when mouse exit the node for first time 

	return data

# check if it can drop
func can_drop_data(_position, _data)->bool:
	return true

# exicute when a dragged control node is dropped
func drop_data(_position, data)->void:
	# move data
	move_layer(data)

	# reset animation
	data["layer"].reset_to_default()
	reset_to_default()

# moves layer
func move_layer(data):
	var map_node:Control = get_parent().get_owner()

	# move the node which was being dragged and is now dropped 'data["layer"]'
	get_parent().move_child(data["layer"], self.get_position_in_parent())
	data["layer_node"].get_parent().move_child(data["layer_node"], self.get_position_in_parent() + 1)
	
	
	# move the node on which the other node is dropped 'self'
	texture_node.get_parent().move_child(texture_node, data["node_position"] + 1)
	get_parent().move_child(self, data["node_position"])
	
	var layers:Array = []
	var layer_nodes:Array = get_parent().get_children()
	for resource in layer_nodes:
		layers.append(resource.map_layer_resources.duplicate())

	map_node.map_resource.layers = layers
	
	EventBus.emit_signal("save_map", map_node.map_resource)

#	map_node.MapSaveSystem.save_map(
#		map_node.map_resource.map_name,
#		map_node.map_resource.image_path,
#		map_node.map_resource.layers,
#		map_node.map_resource.map_pins,
#		map_node.map_resource.tags
#	)

# on being_dragged signal reciver 
func _on_being_dragged(state:bool)->void:
	move = state


# ------------------------------------------------------------------------------

# === LAYER SETTING(s) ===

func set_layer_blend_mode(blend_mode:int)->void:
	map_layer_resources.layer_shader = blend_mode
	texture_node.material            = MapLayer.fetch_shader_material(blend_mode, self.map_layer_resources.layer_custom_shader)
	EventBus.emit_signal('save_map_layer', map_layer_resources, self.get_position_in_parent())

func set_layer_opacity(opacity:float)->void:
	map_layer_resources.layer_opacity = opacity
	texture_node.modulate             = Color(1.0, 1.0, 1.0, float(map_layer_resources.layer_opacity)/100.00)
	EventBus.emit_signal('save_map_layer', map_layer_resources, self.get_position_in_parent())

func set_layer_visibility(visiblity:bool)->void:
	map_layer_resources.layer_visibility = visiblity
	texture_node.visible                 = visiblity
	EventBus.emit_signal('save_map_layer', map_layer_resources, self.get_position_in_parent())


# ------------------------------------------------------------------------------


# === INPUT SYSTEM ===

		### IMPORTANT NOTE ###

# due to the broken nature of built-in mouse 
# enter and exit signal it has been re-written
# the built in is still there but it is
# recommended to not use ti

# check is mouse is inside the node
func if_inside_rect()->bool:
	var is_inside = false
	
	if get_global_mouse_position().x >= self.rect_global_position.x:
		if get_global_mouse_position().x <= self.rect_size.x + self.rect_global_position.x:
			if get_global_mouse_position().y >= self.rect_global_position.y:
				if get_global_mouse_position().y <= self.rect_size.y + self.rect_global_position.y:
					is_inside = true

	return is_inside

# mouse enter and exit system
func check_mouse_enter()->void:
	if if_inside_rect():
		if mouse_enter != true:
			mouse_enter = true
			emit_signal("mouse_pointer_entered")
	if !if_inside_rect():
		if mouse_enter != false:
			mouse_enter = false
			emit_signal("mouse_pointer_exited")

# mouse pointer exit method
func _on_Layers_mouse_pointer_exited()->void:
	if move and hover == true:
		reset_to_default()
		hover = false

# mouse pointer enter method
func _on_Layers_mouse_pointer_entered()->void:
	if move and hover == false:
		set_position_size_value(
			$Panel.rect_position + Vector2(25.0, 0.0),
			$Panel.rect_size - Vector2(25.0, 0.0)
		)
		hover = true

# ------------------------------------------------------------------------------

# SIGNAL RECIVER(s)

# visible button pressed
func _on_Visible_pressed()->void:
	layer_selected()
	get_tree().call_group("layer_option", 'set_layer_visibility', !$Panel/HBoxContainer/Visible.pressed)

# ------------------------------------------------------------------------------

