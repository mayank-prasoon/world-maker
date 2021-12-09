extends Node

export(Script) var mapIcon:Script
export(Script) var mapPin:Script
export(Script) var mapData:Script

var saveLocationData: = 'res://save_files/save_location_data.tres'
var saveIconData:     = 'res://save_files/save_icon_data.tres'
var saveMapData:      = 'res://save_files/save_map_data.tres'

#func _ready() -> void:
#	openFile()

func saveFile() -> void:
	pass
#	_save_location()
#	_save_icon()
#	_save_map_data()
#
#
# save location 
func _save_map_pin(pin_name:String, template:Resource, location:Vector2, article:Resource, link_state:bool, chunk_link:Resource) -> void:

	var newSaveLocation                  = mapPin.new()
	newSaveLocation.pin_name             = pin_name
	newSaveLocation.pin_symbol_template  = template
	newSaveLocation.pin_location         = location
	newSaveLocation.pin_article          = article
	newSaveLocation.map_link_state       = link_state
	newSaveLocation.linked_chunk         = chunk_link

	var _x = ResourceSaver.save(saveLocationData, newSaveLocation)
#
## save icon
#func _save_icon() -> void:
#
#	var newSaveIcon                      = mapIcon.new()
#	newSaveIcon.iconName                 = SystemIconData.iconName
#	newSaveIcon.iconTexture              = SystemIconData.iconTexture
#	newSaveIcon.iconOffset               = SystemIconData.iconOffset
#	newSaveIcon.iconType                 = SystemIconData.iconType
#	newSaveIcon.color                    = SystemIconData.iconColor
#
#	var _x = ResourceSaver.save(saveIconData, newSaveIcon)
#
## save map data
#func _save_map_data() -> void:
#
#	var newSaveMapData                   = mapData.new()
#	newSaveMapData.mapName               = SystemMapData.mapName
#	newSaveMapData.mapTexture            = SystemMapData.mapTexture
#	newSaveMapData.description           = SystemMapData.description
#	newSaveMapData.layerNumber           = SystemMapData.layerNumber
#	newSaveMapData.layerName             = SystemMapData.layerName
#	newSaveMapData.layerTexture          = SystemMapData.layerTexture
#
#	var _x = ResourceSaver.save(saveMapData, newSaveMapData)
#
#func openFile():
#	_open_location()
#	_open_icon()
#	_open_map_data()
#
#
## open location data
#func _open_location():
#	verify(saveLocationData)
#	var newSaveLocation = ResourceLoader.load(saveLocationData)
#
#	SystemLocationData.locationName     = newSaveLocation.locationName
#	SystemLocationData.locationIcon     = newSaveLocation.locationIcon
#	SystemLocationData.map              = newSaveLocation.map
#	SystemLocationData.locationVector2D = newSaveLocation.location
#
## open icon data
#func _open_icon() -> void:
#
#	verify(saveIconData)
#	var newSaveIcon = ResourceLoader.load(saveIconData)
#
#	SystemIconData.iconName             = newSaveIcon.iconName
#	SystemIconData.iconTexture          = newSaveIcon.iconTexture
#	SystemIconData.iconOffset           = newSaveIcon.iconOffset
#	SystemIconData.iconType             = newSaveIcon.iconType
#	SystemIconData.iconColor            = newSaveIcon.color
#
## open map data
#func _open_map_data() -> void:
#
#	verify(saveMapData)
#	var newSaveMapData = ResourceLoader.load(saveMapData)
#
#	SystemMapData.mapName               = newSaveMapData.mapName
#	SystemMapData.mapTexture            = newSaveMapData.mapTexture
#	SystemMapData.description           = newSaveMapData.description
#	SystemMapData.layerName             = newSaveMapData.layerName
#	SystemMapData.layerNumber           = newSaveMapData.layerNumber
#	SystemMapData.layerTexture          = newSaveMapData.layerTexture

func verify(path:String) -> void:
	var file:File = File.new()
	if !file.file_exists(path):
		if !file.file_exists(path.get_base_dir()):
			var dir:Directory = Directory.new()
			var _x = dir.make_dir_recursive(path.get_base_dir())
		saveFile()
