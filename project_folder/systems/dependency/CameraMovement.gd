class_name CameraMovement
extends Camera2D

@export var zoomSpeed: Vector2:Vector2       = Vector2(0.100001, 0.100001)
@export var minZoom: Vector2:Vector2         = Vector2(0.500001, 0.500001)
@export var maxZoom: Vector2:Vector2         = Vector2(2.600001, 2.600001)
@export var defaultPosition: Vector2:Vector2 = Vector2(0, 0)
@export var panSpeed: float:float          = 0.2

var desiredZooom:Vector2 = self.zoom

@export var defaultZoom: Vector2:Vector2 = Vector2(2.0,2.0)

var panning:bool = false
var disableMouse:bool = false : set = set_disable_camera
var desiredOffset:Vector2 = self.offset

func set_disable_camera(value)->void:
	disableMouse = value


func _physics_process(_delta:float) -> void:
	self.zoom = lerp(self.zoom, desiredZooom, 0.2)
	self.offset = lerp(self.offset, desiredOffset, panSpeed)


func _unhandled_input(event:InputEvent) -> void:
	if !disableMouse:
		zoomControl(event)
		cameraMovement(event)
		checkCameraReset(event)

#zoom control
func zoomControl(event:InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():

			# zoom in
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				if minZoom < desiredZooom:
					desiredZooom -= zoomSpeed

			# zoom out
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				if maxZoom > desiredZooom:
					desiredZooom += zoomSpeed


#camera control
func cameraMovement(event:InputEvent)->void:
	if event is InputEventKey:
		if event.is_pressed() and event.scancode == KEY_SPACE:
			panning = true
			EventBus.emit_signal("close_article_panel")
			Input.set_default_cursor_shape(Input.CURSOR_DRAG)
		else:
			panning = false
			Input.set_default_cursor_shape(Input.CURSOR_ARROW)

	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == MOUSE_BUTTON_MIDDLE:
			panning = true
			Input.set_default_cursor_shape(Input.CURSOR_DRAG)
		else:
			panning = false
			Input.set_default_cursor_shape(Input.CURSOR_ARROW)

	if event is InputEventMouseMotion and panning == true:
		desiredOffset -= event.relative * zoom


func checkCameraReset(event:InputEvent)->void:
	if event.is_action_pressed("ui_cancel"):
		cameraReset()


func cameraReset()->void:
	desiredOffset = defaultPosition
	desiredZooom = defaultZoom


func cameraZoomIn()->void:
	if minZoom < desiredZooom:
		desiredZooom -= zoomSpeed


func cameraZoomOut()->void:
	if maxZoom > desiredZooom:
		desiredZooom += zoomSpeed
	
