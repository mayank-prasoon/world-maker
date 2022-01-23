extends Node2D

onready var sprite: = $"Sprite"
onready var collision: = $"Area2D/CollisionShape2D"
onready var area2D: = $"Area2D"

var texture:String
var tag:Color
var type:String
var locationName:String
var textureOffset:Vector2

func _ready() -> void:
	changeOffset()
	sprite.texture = load(texture)
	sprite.self_modulate = tag
	
func changeOffset() -> void:
	sprite.offset -= textureOffset
	collision.shape.radius += textureOffset.y
	collision.position -= textureOffset

func resetOffset() -> void:
	sprite.offset = Vector2(0.0 , -20)
	collision.shape.radius = 40
	collision.position = Vector2(0.198, -18.778)

func addGroup(icon_name) -> void:
	add_to_group(icon_name)

func updateLocation(icon_type, icon_tag, icon_texture, icon_texure_offset) -> void:
	type = icon_type
	
	tag = icon_tag
	texture = icon_texture
	self.get_child(2).texture = load(texture)
	self.get_child(2).self_modulate = tag
	
	resetOffset()
	textureOffset = icon_texure_offset
	changeOffset()
