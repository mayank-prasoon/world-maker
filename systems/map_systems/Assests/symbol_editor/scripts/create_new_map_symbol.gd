class_name NewMapSymbol
extends Node

func createNewSymbol() -> void:
    self.instanceLocation()
    self.assignInstanceData()

func instanceLocation() -> void:
    var new_location = get_parent().icon.instance()
    new_location.addGroup(get_parent().iconName)
	
    self.editInstanceData(new_location)
    self.assignInstanceData()
    self.get_parent().locations.add_child(new_location)

# this function edit the instance data
func editInstanceData(new_location) -> void:
	new_location.texture       = get_parent().iconTexture
	new_location.position      = get_parent().camera.get_global_mouse_position()
	new_location.tag           = get_parent().iconColorTag
	new_location.textureOffset = get_parent().textureOffset

func assignInstanceData():
	SystemLocationData.locationName.append(get_parent().iconName)
	SystemLocationData.locationIcon.append(get_parent().get_index())
	SystemLocationData.locationVector2D.append(get_parent().camera.get_global_mouse_position())
	SystemLocationData.map.append(SystemMapData.currentMapIndex)