extends CameraMovement

var current_image_size = Vector2(1000, 1000)

func _init() -> void:
	add_to_group('camera_movement')
	var _a = EventBus.connect("disable_camera", self, 'set_disable_camera')
	var _b = EventBus.connect("move_camera_to", self, '_on_move_camera_to')
	
	var _c = EventBus.connect("zoom_in", self, '_on_ZoomIn_pressed')
	var _d = EventBus.connect("zoom_out", self, '_on_ZoomOut_pressed')
	var _e = EventBus.connect("reset_zoom", self, '_on_Rest_pressed')

func _ready() -> void:
	get_tree().call_group('map_element', 'change_scale', desiredZooom)


func setup_camera_for_map(camera_position:Vector2, image_size:Vector2)->void:
	self.defaultPosition = camera_position
	current_image_size   = image_size
	self.cameraReset()


func _physics_process(_delta:float)->void:
	var new_zoom_value = current_image_size/OS.get_window_size()
	if new_zoom_value.x == new_zoom_value.y:
		self.defaultZoom = new_zoom_value
	else:
		if new_zoom_value.x > new_zoom_value.y:
			self.defaultZoom = Vector2(new_zoom_value.x, new_zoom_value.x)
		else:
			self.defaultZoom = Vector2(new_zoom_value.y, new_zoom_value.y)
	
	self.maxZoom = self.defaultZoom * Vector2(1.5, 1.5)


func _on_move_camera_to(vector:Vector2)->void:
	self.desiredOffset = vector


func _on_ZoomIn_pressed()->void:
	cameraZoomIn()
	

func _on_ZoomOut_pressed()->void:
	cameraZoomOut()


func _on_Rest_pressed()->void:
	cameraReset()
