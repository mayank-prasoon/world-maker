extends Node2D

onready var parent = get_parent()

var followMouse:bool = false
var desiredPosition:Vector2 = self.position

func _physics_process(_delta: float) -> void:
	var mouse_pos:Vector2 = get_global_mouse_position()
	if followMouse:
#		SystemLocationData.locationVector2D[parent.get_index()] = mouse_pos
		parent.position = mouse_pos

	if Input.is_action_just_released("left_mouse_click"):
		followMouse = false

func _on_Area2D_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == BUTTON_LEFT:
				followMouse = true
