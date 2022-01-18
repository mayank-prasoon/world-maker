class_name CameraMovement
extends Camera2D

export(Vector2) var zoomSpeed:Vector2 = Vector2(0.100001, 0.100001)
export(Vector2) var minZoom:Vector2 = Vector2(0.500001, 0.500001)
export(Vector2) var maxZoom:Vector2 = Vector2(2.600001, 2.600001)

var desiredZooom:Vector2 = self.zoom

export(Vector2) var defaultZoom:Vector2 = Vector2(2.0,2.0)

var panning:bool = false
var disableMouse:bool = false
var desiredOffset:Vector2 = self.offset


func _physics_process(_delta: float) -> void:
	self.zoom = lerp(self.zoom, desiredZooom, 0.2)
	self.offset = lerp(self.offset, desiredOffset, 0.2)


func _input(event: InputEvent) -> void:
	if !disableMouse:
		zoomControl(event)
		cameraMovement(event)
		checkCameraReset(event)

#zoom control
func zoomControl(event:InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():

			# zoom in
			if event.button_index == BUTTON_WHEEL_UP:
				if minZoom < desiredZooom:
					desiredZooom -= zoomSpeed

			# zoom out
			if event.button_index == BUTTON_WHEEL_DOWN:
				if maxZoom > desiredZooom:
					desiredZooom += zoomSpeed

#camera control
func cameraMovement(event:InputEvent)->void:
	if event.is_action_pressed("drag"):
		panning = true
	elif event.is_action_released("drag"):
		panning = false
	if event is InputEventMouseMotion and panning == true:
		desiredOffset -= event.relative * zoom


func checkCameraReset(event:InputEvent)->void:
	if event.is_action_pressed("ui_cancel"):
		cameraReset()


func cameraReset()->void:
	desiredOffset = Vector2(0,0)
	desiredZooom = defaultZoom


func cameraZoomIn()->void:
	if minZoom < desiredZooom:
		desiredZooom -= zoomSpeed


func cameraZoomOut()->void:
	if maxZoom > desiredZooom:
		desiredZooom += zoomSpeed
	
