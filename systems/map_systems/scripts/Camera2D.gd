# this node extends the CameraMovement Class which is controls the input and the movement of the map
extends CameraMovement

func _ready() -> void:
	add_to_group('camera_movement')

func changeStateTo(state) -> void:
	disableMouse = state
