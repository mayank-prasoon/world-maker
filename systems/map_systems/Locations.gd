extends Control

# === EXPORT ===

# this is the 
export(PackedScene) var tempLocation:PackedScene = preload("res://Scene/map/Assests/location/Location.tscn")

# === VERIABLE ===

var mapData:Array

# === INITIALISATION ===

func _ready() -> void:
	add_to_group('locations')
	
	# this loads the map pin from the system inventory
	for x in SystemLocationData.locationName.size():
		if SystemLocationData.map[x] == SystemMapData.currentMapIndex:
			instanceLocation(x)

# === FUNCTIONS ===

func instanceLocation(index:int, location:PackedScene = tempLocation) -> void:
# this instances the map in add it to the map
# index : it is the index of the map in the system inventory 
# location : it is the packed scene loaded as a template
	var new_location: = location.instance()
	new_location.addGroup(SystemIconData.iconName[SystemLocationData.locationIcon[index]])
	editInstanceData(new_location, index)
	self.add_child(new_location)

func editInstanceData(new_location, index:int) -> void:
# this edit the instance of the map pin
# new_locaion : new instance of the location [packed scene]
# index : it is the index of the map in the system inventory 
	new_location.texture       = SystemIconData.iconTexture[SystemLocationData.locationIcon[index]]
	new_location.position      = SystemLocationData.locationVector2D[index]
	new_location.tag           = SystemIconData.iconColor[SystemLocationData.locationIcon[index]]
	new_location.textureOffset = SystemIconData.iconOffset[SystemLocationData.locationIcon[index]]

func refreshLocation()->void:
# this refresh the map icon
	for x in self.get_children():
		self.remove_child(x)

	for y in SystemLocationData.locationName.size():
		if SystemLocationData.map[y] == SystemMapData.currentMapIndex:
			instanceLocation(y)
