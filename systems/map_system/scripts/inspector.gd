extends Control


#show the inspector
export var state       = false

var switch:Object      = Switch.new(self, 'open_inspector', 'close_inspector') 

# node
onready var container_node = $Panel/VboxContainer/Inspector/Inspector

class Switch extends Reference:
	var state = true

	var object          = null
	var method_1:String = ""  # method called when the state is true
	var method_2:String = ""  # method called when the state is false
	
	func _init(node, true_state_method:String, false_state_method:String)->void:
		self.object = node
		self.method_1 = true_state_method
		self.method_2 = false_state_method
	
	func switch()->void:
		if state:
			object.call(method_1)
		else:
			object.call(method_2)

		state = !state

# ------------------------------------------------------------------------------

func _ready():
	add_to_group("inspector")
	var _x = EventBus.connect("change_inspector_state", self, 'change_inspector_state')
	var _y = EventBus.connect("clear_inspector", self, 'clear_inspector')
	var _z = EventBus.connect("add_pin_inspector", self, 'add_map_pin_inspector')
	var _p = EventBus.connect("add_comment_inspector", self, 'add_map_comment_inspector')
# ------------------------------------------------------------------------------

# toggle the display
func display_toggle()->void:
	switch.switch()

# ------------------------------------------------------------------------------

# play open animation
func open_inspector()->void:
	state = true
	
	inspector_slide_animation(
		Vector2(315, 0),
		Vector2(0, 0)
	)


# play close animation
func close_inspector()->void:
	state = false
	
	inspector_slide_animation(
		Vector2(0, 0),
		Vector2(315, 0)
	)


# change inspector
func change_inspector_state(new_state)->void:
	if state != new_state:
		display_toggle()

# ------------------------------------------------------------------------------

# play the open/close animation of the inspector
func inspector_slide_animation(init_pos, final_pos)->void:
	$Tween.interpolate_property(
		get_child(0),
		"rect_position",
		init_pos,
		final_pos,
		0.5,
		Tween.TRANS_CUBIC,
		Tween.EASE_IN_OUT
	)
	
	$Tween.start()

# ------------------------------------------------------------------------------

# add map pin inspector
func add_map_pin_inspector(map_pin_resource:MapPin, map_pin_node:Node2D) -> void:
	for x in container_node.get_children():
		x.queue_free()

	var scene:PackedScene = load("res://systems/map_system/ui_elements/map_element_inspector/MapPinInspector.tscn")
	var map_pin_inspector_node:Control = scene.instance()

	map_pin_inspector_node.resource_file = map_pin_resource
	map_pin_inspector_node.map_pin_node  = map_pin_node
	container_node.add_child(map_pin_inspector_node)

# ------------------------------------------------------------------------------

# add map comment inspector
func add_map_comment_inspector(map_comment_resource:MapComment, map_comment_node:Node2D)->void:
	for x in container_node.get_children():
		x.queue_free()
	
	var scene:PackedScene = load("res://systems/map_system/ui_elements/map_element_inspector/MapCommentInspector.tscn")
	var map_comment_inspector_node:Control = scene.instance()

	map_comment_inspector_node.resource_file    = map_comment_resource
	map_comment_inspector_node.map_comment_node = map_comment_node
	container_node.add_child(map_comment_inspector_node)

# ------------------------------------------------------------------------------

func clear_inspector() -> void:
	for x in container_node.get_children():
		x.queue_free()

	var label  = Label.new()
	label.text = "select an element on the map"

	label.valign = Label.ALIGN_CENTER
	label.align  = Label.ALIGN_CENTER

	label.anchor_bottom = 1
	label.anchor_right  = 1

	label.size_flags_horizontal = Label.SIZE_EXPAND_FILL
	label.size_flags_vertical   = Label.SIZE_EXPAND_FILL

	container_node.add_child(label)
