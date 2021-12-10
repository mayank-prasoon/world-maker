extends Node

export(Script) var mapSymbolTemplate:Script = preload("res://assets/file templates/save_system_template/map_symbol_template_resources_template.gd")
export(Script) var mapPin:Script            = preload("res://assets/file templates/save_system_template/map_pin_resources_template.gd")
export(Script) var mapData:Script           = preload("res://assets/file templates/save_system_template/map_resources_template.gd")


var savePinData:         = 'res://save_files/pins/{pin_name}_save_data.tres'
var savePinTemplateData: = 'res://save_files/symbol_templates/{template_name}_save_data.tres'
var saveMapData:         = 'res://save_files/save_map_data.tres'

enum MAP_RESOURCE_TYPE {
	PIN,
	PIN_TEMPLATE,
	MAP,
	MAP_CHUNK
}

#func _ready() -> void:
#	openFile()

func saveFile() -> void:
	pass

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
#	_open_Pin()
#	_open_icon()
#	_open_map_data()
#
#
# open map pin data

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

func verify(path:String, _type:int, resource_name:String) -> void:
	var file:File = File.new()
	if !file.file_exists(path):
		if !file.file_exists(path.get_base_dir()):
			var dir:Directory = Directory.new()
			var _x = dir.make_dir_recursive(path.get_base_dir())
		match _type:
			MAP_RESOURCE_TYPE.PIN:
				$PinSystem._save_file(resource_name)
			MAP_RESOURCE_TYPE.PIN_TEMPLATE:
				$SymbolTemplateSystem._save_file(resource_name)
