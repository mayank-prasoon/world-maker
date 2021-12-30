extends Control

# === SIGNALS ===
# this is emited when the back backgrounded is loaded
signal image_loaded

# === NODES ===
onready var map:       = $Map
#onready var selectMap: = $"../Camera2D/CanvasLayer/MapMenu/Menu/SelectMapMenu"
onready var location:  = $Locations

# === VERIALBLES ===
var basic:String = "res://assests/map/u6gsbpham1s41.jpg"

# === THREADS ===
var thread: = Thread.new()
var mutex:Mutex = Mutex.new()

# === FUNCTIONS ===
func _ready() -> void:
	add_to_group('map_manager')
	loadMap(basic)
	call_deferred('emit_signal', "image_loaded")

#	if SystemMapData.mapTexture.size() != 0:
#		for x in SystemMapData.mapName:
#			selectMap.addMap(x)
#		changeAddMap(SystemMapData.mapTexture[SystemMapData.currentMapIndex - 1])
#		selectMap.get_child(2).selected = SystemMapData.currentMapIndex
#		loadMap(basic)
#	else:
#		loadMap(basic)
#		call_deferred('emit_signal', "image_loaded")

func loadMap(path:String):
# This imports the map into the system add the texture
	var image: = ResourceLoader.load(path)
	map.texture = image


func newAddMap(map_name:String, map_texture:String) -> void:
# This method add new map and texture to the system invetory
# [the systme inventory is the SystemMapData singleton]
	SystemMapData.mapName.append(map_name)
	SystemMapData.mapTexture.append(map_texture)
#	selectMap.addMap(SystemMapData.mapName[-1])


func changeAddMap(texture):
	if thread.is_active():
		thread.wait_to_finish()
	var _t = thread.start(self, 'loadMap', texture)
	get_tree().call_group('locations', 'refreshLocation')


func _exit_tree() -> void:
	if thread.is_active():
		thread.wait_to_finish()

# === SIGNALS ===
func _on_SelectMapMenu_change_map(index) -> void:
	changeAddMap(SystemMapData.mapTexture[index])
	SystemMapData.currentMapIndex = index
