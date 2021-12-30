extends Button

var follow:bool = false

func _ready() -> void:
	self.expand_icon = true
	self.icon = load(get_parent().iconTexture)
	var _x: = connect("gui_input", $PopUP, "_on_Button_gui_input")

func _on_Button_pressed() -> void:
	follow = true
	self.focus_mode = Control.FOCUS_NONE
	get_parent().placeholder.show()
	get_parent().placeholder.self_modulate = get_parent().iconColorTag
	get_parent().placeholder.texture = load(get_parent().iconTexture)
	
func _process(_delta: float) -> void:
	if follow:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		get_parent().placeholder.position = get_global_mouse_position()

	if Input.is_action_just_pressed("left_mouse_click") and follow:
		follow = false
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_parent().placeholder.hide()
		instanceLocation()
		var x: = get_tree().get_root().get_node("/root/Map/Camera2D/CanvasLayer/EditLocation")
		x.popOpen()

func instanceLocation() -> void:
	var new_location = get_parent().icon.instance()
	new_location.addGroup(get_parent().iconName)
	editInstanceData(new_location)
	assignInstanceData()
	get_parent().locations.add_child(new_location)

func editInstanceData(new_location) -> void:
	new_location.texture = get_parent().iconTexture
	new_location.position = get_parent().camera.get_global_mouse_position()
	new_location.tag = get_parent().iconColorTag
	new_location.textureOffset = get_parent().textureOffset

func assignInstanceData():
	SystemLocationData.locationName.append(get_parent().iconName)
	SystemLocationData.locationIcon.append(get_parent().get_index())
	SystemLocationData.locationVector2D.append(get_parent().camera.get_global_mouse_position())
	SystemLocationData.map.append(SystemMapData.currentMapIndex)
