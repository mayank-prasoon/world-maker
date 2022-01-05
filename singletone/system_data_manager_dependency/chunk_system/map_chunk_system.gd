extends Node

onready var save_system    = get_node("SaveSystem")
onready var system_manager = get_node("MapChunkManager")

func _ready():
	Logger.info(name + " - loaded")

func create_new_chunk(
		chunk_name:String,
		chunk_texture:Texture = Texture.new(),
		chunk_offset:Vector2  = Vector2(0,0),
		pin:Array             = []
	) -> String:

	var uuid = get_parent().uuid_util.v4()

	save_system.save_file(
		chunk_name,
		uuid,
		chunk_texture,
		chunk_offset,
		pin
	)

	CommandSystem.API.echo("new chunk generated")

	return uuid
