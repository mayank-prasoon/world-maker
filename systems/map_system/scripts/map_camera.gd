extends CameraMovement

func _ready() -> void:
	add_to_group('camera_movement')

func setup_camera_for_map(camera_position):
	self.defaultPosition = camera_position
	self.cameraReset()


func _on_ZoomIn_pressed():
	cameraZoomIn()


func _on_ZoomOut_pressed():
	cameraZoomOut()

func _on_Rest_pressed():
	cameraReset()


