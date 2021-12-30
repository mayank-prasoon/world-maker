extends Control


# packed scene that will be instanced
export(PackedScene) var icon:PackedScene = preload("res://Scene/map/Assests/location/Location.tscn")

export(String, FILE) var iconTexture:String                                      # icon images
export(Vector2) var textureOffset:Vector2                                       # texture offest
export(Color)   var iconColorTag:Color
export(String)  var type:String                                                  # type of icon
export(String)  var iconName:String                                              # name of the icon

onready var button: = $"Button"
onready var locations: = $"../../../../../../../../MapEditor/Locations"
onready var camera: = $"../../../../../../.."
onready var placeholder: = $"../../../../../../Sprite"


func _ready() -> void:
	add_to_group('location_icon')
	button.self_modulate = iconColorTag

func _on_Delete_pressed() -> void:
	self.queue_free()

func updateIcon(icon_name:String, icon_type:String, texture:String, tag:Color, offset:Vector2) -> void:
	iconName = icon_name
	type = icon_type
	
	# change texture	
	iconTexture = texture
	button.icon = load(texture)
	
	# change color
	iconColorTag = tag
	button.self_modulate = tag
	
	# change offset
	textureOffset = offset
