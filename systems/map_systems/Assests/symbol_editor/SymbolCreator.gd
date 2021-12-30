extends Node

# packed scene that will be instanced
export(PackedScene) var icon:PackedScene = preload("res://Scene/map/Assests/location/Location.tscn")                                          # name of the icon

onready var symbolSystemInventory:Node   = $"../SymbolData"

func instanceLocation(index) -> void:
	var new_location = icon.instance()
	new_location.addGroup(symbolSystemInventory.symbolNameText)
	editInstanceData(new_location, index)
	assignInstanceData(symbolSystemInventory.symbolNameText)
	get_parent().locations.add_child(new_location)


func editInstanceData(new_location, index:int) -> void:
	new_location.position = get_parent().mousePosition
	new_location.texture = SystemIconData.iconTexture[index]
	new_location.textureOffset = SystemIconData.iconOffset[index]
	new_location.tag = Color.white


func assignInstanceData(name:String)->void:
	SystemLocationData.locationName.append(name)
	SystemLocationData.locationIcon.append(get_parent().get_index())
	SystemLocationData.locationVector2D.append(get_parent().mousePosition)
	SystemLocationData.map.append(SystemMapData.currentMapIndex)
