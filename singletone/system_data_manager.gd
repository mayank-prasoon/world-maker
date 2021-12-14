extends Node

# === EXPORTS ===

export(String, DIR) var root_save_file_path:String  = "res://save_files"

# save file templates
export(Script) var mapSymbolTemplate:Script         = preload("res://assets/file templates/save_system_template/map_symbol_template_resources_template.gd")
export(Script) var mapPin:Script                    = preload("res://assets/file templates/save_system_template/map_pin_resources_template.gd")
export(Script) var mapChunk:Script                  = preload("res://assets/file templates/save_system_template/map_chunk_resources_template.gd")
export(Script) var map:Script                       = preload("res://assets/file templates/save_system_template/map_resources_template.gd")

export(Script) var article:Script                   = preload("res://assets/file templates/save_system_template/root_article_template.gd")

# === NODES AND RESOURCES ===

onready var pinSystem       = self.get_node("PinSystem")
onready var symbolSystem    = self.get_node("SymbolTemplateSystem")
onready var mapChunkSystem  = self.get_node("MapChunkSystem")                   # acess mapChunkSystem
onready var systemInventory = self.get_node("SystemInventory")                  # acess to the system wide data

# === VERIABLES ===
const uuid_util = preload("res://utilities/godot-uuid-master/uuid.gd")

enum MAP_RESOURCE_TYPE {
	PIN,
	PIN_TEMPLATE,
	MAP,
	MAP_CHUNK,
	ARTICLE
}

func verify(path:String, _type:int, resource_name:String) -> void:
	var file:File = File.new()
	if !file.file_exists(path):
		if !file.file_exists(path.get_base_dir()):
			var dir:Directory = Directory.new()
			var _x = dir.make_dir_recursive(path.get_base_dir())
		match _type:
			MAP_RESOURCE_TYPE.PIN:
				$PinSystem/SaveSystem.save_file("", resource_name)
			MAP_RESOURCE_TYPE.PIN_TEMPLATE:
				$SymbolTemplateSystem/SaveSystem.save_file(resource_name)
			MAP_RESOURCE_TYPE.MAP_CHUNK:
				$MapChunkSystem/SaveSystem.save_file("", resource_name)
			MAP_RESOURCE_TYPE.MAP:
				$MapSystem/SaveSystem.save_file(resource_name)
			MAP_RESOURCE_TYPE.ARTICLE:
				$ArticleSystem/SaveSystem.save_file(resource_name)
